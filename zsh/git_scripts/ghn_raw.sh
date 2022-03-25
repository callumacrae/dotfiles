#!/usr/bin/env zsh

# todo - make this work in bash

rest_data=$(gh api notifications --paginate -q '
	reduce .[] as $item ({}; . + {
		($item.subject.url | split("/") | (((.[-4] + .[-3]) | gsub("-"; "")) + .[-1])): {
			threadId: $item.id | tonumber,
			number: $item.subject.url | split("/")[-1] | tonumber,
			title: $item.subject.title,
			owner: $item.repository.owner.login,
			repo: $item.repository.name,
			reason: $item.reason,
			updated_at: $item.updated_at
		}
	})')

[[ $rest_data == "{}" ]] && exit 0

# loooooooool
# github pls give us a notifications graphql api pls
query=$(echo $rest_data | jq -r '"{" + (map(
	((.owner + .repo) | gsub("-"; "")) + (.number | tostring) + ": repository(owner: \"" + .owner + "\", name: \"" + .repo + "\") {
		issueOrPullRequest(number: " + (.number | tostring) + ") {
			__typename,
			...on Issue { state, url },
			...on PullRequest { state, url }
		}
	}")
	| join(",")) + "}"')

graphql_data=$(gh api graphql --paginate -f query=$query -q '.data
	| to_entries
	| reduce .[] as $item ({}; . + {
		($item.key): ($item.value.issueOrPullRequest | { type: .__typename, state: .state, url: .url })
	})')

data=$(echo "${rest_data}" "${graphql_data}" | jq -s '.[0] * .[1]')

rm $TMPDIR/ghn_cache_data.json
echo $data > $TMPDIR/ghn_cache_data.json

echo $data | jq -r '
	def colors: {
		"reset": "\u001b[0m", "dim": "\u001b[2m", "red": "\u001b[0;31m", "green": "\u001b[0;32m", "purple": "\u001b[0;95m", "white": "\u001b[1;37m"
	};
	def icon:
		if .type == "PullRequest"
			then (if .state == "OPEN" then colors.green + "" elif .state == "MERGED" then colors.purple + "" else colors.red + "" end)
			else (if .state == "OPEN" then colors.green else colors.red end) + ""
		end;
	def fuzzytime:
		(now - (. | fromdate))
			| if . < 60 then (. | round | tostring) + " seconds ago"
				elif . < 3600 then (. / 60 | round | tostring) + " minutes ago"
				elif . < 3600 * 24 then (. / 60 / 24 | round | tostring) + " hours ago"
				else (. / 60 / 24 / 7 | round | tostring) + " days ago"
				end;
	map(
			colors.green + .owner + "/" + .repo + colors.reset
			+ colors.dim + "#" + (.number | tostring) + colors.reset + "@@"
			+ (. | icon) + " "
			+ colors.white + .title + colors.reset + "@@"
			+ colors.dim + .reason + " - " + (.updated_at | fuzzytime)
	)
		| join("\n")' | column -t -s "@@"
