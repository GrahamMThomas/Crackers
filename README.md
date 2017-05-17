# Red Team Tool: *Crackers*

**Crackers** is hash cracking SlackBot which automatically determines the hash type and then attempts to crack the hash based on the chosen wordlist.

Created by: **Graham Thomas**

## User Stories

The following **required** functionality is complete:
* [X] Analyze a hash to determine the type of hash using hashid
* [X] Pass the hash_id number to hashcat to crack the hash.
* [X] Return value and post status updates to slack

Potential future improvements:
* [X] Attempt to crack using every hash_type returned by hashid


## Video Walkthrough


![alt text](https://github.com/GrahamMThomas/Crackers/blob/master/images/Crackers_example.gif "Demo")

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Library's Used
Hashcat - https://github.com/hashcat/hashcat

Hashid - https://github.com/psypanda/hashID

Slack Ruby Bot - https://github.com/slack-ruby/slack-ruby-bot


## License

    Copyright [2016] [Graham Thomas]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
