#! /bin/sh

source .config

echo "Creating JIRA in Project: $1"
echo "Title: $2"

CREATE_DATA=$(cat <<EOF
{
    "fields": {
       "project":
       {
          "key": "$1"
       },
       "summary": "$2",
       "description": "",
       "issuetype": {
          "name": "Task"
       }
   }
}
EOF
)

CREATED_KEY=$(curl \
   --fail --silent --show-error \
   -u $JIRA_USER:$JIRA_KEY \
   -X POST \
   --data "$CREATE_DATA" \
   -H "Content-Type: application/json" \
   https://datatamr.atlassian.net/rest/api/2/issue/ | jq -r ".key")

TRANSITION_DATA=$(cat <<EOF
{
    "transition": {
      "id": 21
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
   https://datatamr.atlassian.net/rest/api/2/issue/$CREATED_KEY/transitions

open "https://datatamr.atlassian.net/browse/$CREATED_KEY"
