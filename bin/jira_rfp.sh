#! /bin/sh

source .config

BRANCH=$(git rev-parse --abbrev-ref HEAD)

[[ "$BRANCH" =~ ([a-zA-Z]+-[0-9]+).* ]]

# Find the ticket
ISSUE_KEY=${BASH_REMATCH[1]}

TRANSITION_ID=$(curl \
   -u $JIRA_USER:$JIRA_KEY \
   --fail --silent --show-error \
   -X GET \
   -H "Content-Type: application/json" \
   https://datatamr.atlassian.net/rest/api/2/issue/$ISSUE_KEY/transitions | jq -r '.transitions[] | select(.name | test("^Ready For Production$";"i")) | .id')

TRANSITION_DATA=$(cat <<EOF
{
    "transition": {
      "id": ${TRANSITION_ID}
   }
}
EOF
)

curl \
   -u $JIRA_USER:$JIRA_KEY \
   --fail --silent --show-error \
   -X POST \
   --data "$TRANSITION_DATA" \
   -H "Content-Type: application/json" \
   https://datatamr.atlassian.net/rest/api/2/issue/$ISSUE_KEY/transitions
