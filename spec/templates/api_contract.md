# API Contract

## Endpoint
- Method: GET | POST | PUT | DELETE
- Path: /v1/resource
- Auth: bearer | none

## Request
- Headers: { "Content-Type": "application/json" }
- Query params: ?limit=...&cursor=...
- Body (JSON):
`json
{
  "field": "value"
}
`

## Responses
- 200 OK
`json
{
  "id": "...",
  "data": []
}
`
- 4xx/5xx Errors
`json
{
  "error": {
    "code": "...",
    "message": "..."
  }
}
`

## Notes
- Rate limits, pagination, idempotency, versioning.
