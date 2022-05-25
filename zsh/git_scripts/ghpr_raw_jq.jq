	def colors: {
		"reset": "\033[0m", "dim": "\033[2m", "red": "\033[0;31m", "green": "\033[0;32m", "yellow": "\033[0;33m", "blue": "\033[0;34m", "white": "\033[1;37m"
	};
	def truncateMaybe:
		.[0:49] + (if . | length > 49 then "…" else "" end);
	def checkRowStatus:
		if .conclusion == ""
			then (if .status == "" then .state else .status end)
			else .conclusion
		end
			| ascii_downcase
			| if . == "error" then "failure" else .
		end;
	def checkStatusSummary:
		if . != null
			then (map(. | checkRowStatus)
				| reduce .[] as $item ({ total: 0 }; . + { ($item): ((.[$item] // 0) + 1), total: (.total + 1) })
				| if .failure
						then colors.red + "× " + (.failure | tostring) + "/" + (.total | tostring) + " checks failing"
						else colors.green + "✓ " + (.total | tostring) + " checks passing"
					end)
			else colors.yellow + " checks in progress"
			end;
	def reviewSummary:
		if .reviewDecision == "APPROVED"
			then colors.green + "✓ " + (.reviews | length | tostring) + " approved"
			elif .reviewDecision == "REVIEW_REQUIRED" then colors.yellow + "- review required"
			else colors.red + "× changes requested"
		end;
	map(
		colors.dim + "#" + (.number | tostring) + colors.reset + "@@"
			+ colors.white + (.title | truncateMaybe) + colors.reset + "@@"
			+ (.statusCheckRollup | checkStatusSummary) + colors.reset + "@@"
			+ (. | reviewSummary) + "@@"
			+ colors.blue + .headRefName + colors.reset
	)	| join("\n")
