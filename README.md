# mongodb-agents Cookbook

Installs Mongo MMS backup and monitoring agents

## Requirements

### Platform

Currently Ubuntu and Debian are supported

## Attributes

* `node['mongodb-agents']['backup']['version']` - Backup agent version number
* `node['mongodb-agents']['monitoring']['version']` - Monitoring agent version number
* `node['mongodb-agents']['api_key']` - API Key 

## Usage

Add the API key to you node and then include the recipes for the agent you want installed

```json
{
  "mongodb-agents": {
    "api_key": "xxxxxxxxxxxxxxx"
  }
}
```

### mongodb-agents::backup

```ruby
include_recipe "mongodb-agents::backup"
```

### mongodb-agents::monitoring

```ruby
include_recipe "mongodb-agents::monitoring"
```

## License and Authors
* Authors: Bill Moritz <billmoritz@gmail.com>
* Copyright: 2015, Bill Moritz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
