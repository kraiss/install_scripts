## Gitlab - See all opened Merge Requests

```sh
curl -k --header "PRIVATE-TOKEN: TOKEN" "https://gitlabhost.com/api/v4/merge_requests?scope=all&state=opened&source_branch=source_branch"
```
