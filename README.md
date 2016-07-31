# Bubble.kiwi website

A static site as part of our entry into GovHack2016.

This website consumes data from the [TwoCatsAndSomeMice/bubble-kiwi-data](https://github.com/TwoCatsAndSomeMice/bubble-kiwi-data) repo as a Git submodule.

## Installation

### Dependencies

- Ruby, v2.3.1+
- NodeJS, v6+

### Installation steps

```
git clone --recursive git@github.com:TwoCatsAndSomeMice/bubble-kiwi-website.git
bundle install
npm install
```

## Development

To start a local server (once the dependencies are installed) you'll need to:

```
middleman
```

Then browse to [http://localhost:4567](http://localhost:4567)

## Deployment

After installation, deployment happens using a few console commands.

First, make sure you've checked out `master` in Git.

```
git checkout master
```

Then run the following commands:

```
APP_ENV=production middleman build
APP_ENV=production middleman deploy
```

After a few minutes the site will be pushed to [http://bubble.kiwi](http://bubble.kiwi/)
