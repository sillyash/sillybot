# sillybot
A silly Discord bot

## Test the command

### Usage

```bash
./discohook <json file> <webhook url>
```

```bash
./discohook --ban <user_id>
```

Note that the `--ban` command doesn't ban someone, it just send a quirky message mentioning that person.

Where the JSON file is a Discord Webhook JSON [like this](https://gist.github.com/Birdie0/78ee79402a4301b1faf412ab5f1cdcf9).

### Example

```bash
./discohook.sh $PWD/test-json.json [your webhook url]
```
