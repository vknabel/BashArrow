# 🏹 Bash Arrow


Run bash scripts out of your Archerfile.
For more information about Archery itself head to [vknabel/Archery](https://github.com/vknabel/Archery).


Run bash scripts out of your Archerfile. For more information about Archery itself head to [vknabel/Archery](https://github.com/vknabel/Archery).

```json
{
	"name": "SupercoolProject",
	"version": "1.0.0",
	"scripts": {
		"greet": {
			"arrow": "vknabel/BashArrow",
			"command": "echo Hello"
      }
  }
}
```

All parameters will be passed to your script.
```bash
$ archery greet
Hello
$ archery greet World
Hello World
```


## Available Options

| Name | Type | Default |
|------|------|---------|
| command | `String` | Required |
| printCommandBeforeExecution | `Bool?` | `true` |
| workingDirectory | `String?` | current directory |

## Contributors
* Valentin Knabel, [@vknabel](https://github.com/vknabel), dev@vknabel.com, [@vknabel](https://twitter.com/vknabel) on Twitter


## License
Archery is available under the [](https://github.com/vknabel/archery/master/LICENSE) license.
