# git_changie

A Dart command-line tool for generating changelogs from Git commit messages, enriched with emoji categorization. `git_changie` allows for easy tracking of changes in your project while promoting a standardized commit message format.

## Features

- Generates changelogs based on commit messages.
- Supports emoji categorization for better organization.
- Custom categories can be added as needed
- Flexible filtering by date and tags.

## Installation

### From GitHub

You can clone the repository and build it locally:

```bash
git clone https://github.com/Shreemanarjun/git_changie.git
cd git_changie
dart pub get
```
## Activate Globally



Run 

```bash
dart pub global activate git_changie 
```

To generate `CHANGELOG.MD`
```bash
git_changie
```



## First-Class Support with Gitmoji Plugin for VS Code

For a more visually appealing commit message experience, you can integrate the **Gitmoji** plugin for Visual Studio Code. This plugin provides a list of emojis to choose from, helping you maintain consistency in your commit messages. 

To install the Gitmoji extension:

1. Open VS Code.
2. Go to Extensions (Ctrl+Shift+X).
3. Search for "Gitmoji" and install it.
4. Follow the extension's instructions to start using Gitmoji in your commit messages.

## Usage

Run the `git_changie` command in your terminal with various options to customize the output. Here are some common usages:

### Basic Command

To generate a changelog from your Git commits:

```bash
git_changie
```

### Include Commit Hash, Author, and Date

You can include the commit hash, author, and date in your changelog:

```bash
git_changie --hash --author --date
```

### Filter by Tags

Generate a changelog starting from a specific tag:

```bash
git_changie --from-tag v1.0.0
```

Or up to a specific tag:

```bash
git_changie --to-tag v2.0.0
```

### Filter by Date

You can filter commits by date ranges:

```bash
git_changie --since 2024-01-01 --until 2024-09-30
```

### Specify Output File

To specify a custom output file for the changelog:

```bash
git_changie --output my_changelog.md
```

### Add Custom Categories

You can add custom categories for your changelog entries:

```bash
git_changie --add-category "Custom Category"
```

### Help Command

For a full list of options, run:

```bash
git_changie --help
```

## Contributing

Feel free to submit issues, pull requests, or suggestions. 

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
