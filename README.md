# `git_changie` 🎉

`git_changie` is a powerful Dart command-line tool designed to simplify the generation of changelogs from Git commit messages while promoting a standardized commit message format. 🚀

# Features 🚀

## General Features 🌟
- **Changelog Generation**: Automatically generates a changelog from Git commit messages.
- **Output File Customization**: Specify the output file name (default: `CHANGELOG.md`).
- **Backup Existing Changelog**: Automatically creates a backup of the existing changelog file before overwriting it.

## Command-Line Options 📜
- `--hash`: Include commit hash in the changelog.
- `--author`: Include commit author in the changelog.
- `--date`: Include commit date in the changelog.
- `--from-tag <tag>`: Generate changelog starting from a specific Git tag.
- `--to-tag <tag>`: Generate changelog up to a specific Git tag (inclusive).
- `--since <date>`: Generate changelog starting from a specific date (format: YYYY-MM-DD).
- `--until <date>`: Generate changelog up to a specific date (format: YYYY-MM-DD).
- `--output <file>`: Specify the output file name (default: `CHANGELOG.md`).
- `--add-category <name>`: Add a custom category for commit messages if needed.
- `--help`: Show help message with usage instructions.

## Emoji Categorization 😊
- Supports a variety of emoji categories for better organization of commit messages, including:
  - 🎨 Style
  - ⚡️ Performance
  - 🔥 Remove
  - 🐛 Fixes
  - 🚑 Critical Hotfix
  - ✨ Features
  - 📝 Documentation
  - 🚀 Deployment
  - 💄 UI Changes
  - 🎉 Initial Commit
  - ✅ Tests
  - 🔒️ Security
  - 🔐 Secrets
  - 🔖 Release Tags
  - 🚨 Warnings
  - 🚧 Work In Progress
  - 💚 CI Build
  - ⬇️ Downgrade
  - ⬆️ Upgrade
  - 📌 Pin Dependencies
  - 👷 CI System
  - 📈 Analytics
  - ♻️ Refactor
  - ➕ Add Dependency
  - ➖ Remove Dependency
  - 🔧 Configuration
  - 🔨 Development Scripts
  - 🌐 Internationalization
  - ✏️ Typos
  - 💩 Bad Code
  - ⏪ Revert
  - 🔀 Merge
  - 📦 Compiled Files
  - 👽️ API Changes
  - 🚚 Move/Rename Resources
  - 📄 License
  - 💥 Breaking Changes
  - 🍱 Assets
  - ♿️ Accessibility
  - 💡 Comments
  - 🍻 Drunken Code
  - 💬 Text Changes
  - 🗃️ Database Changes
  - 🔊 Logs
  - 🔇 Remove Logs
  - 👥 Contributors
  - 🚸 User Experience
  - 🏗️ Architectural Changes
  - 📱 Responsive Design
  - 🤡 Mocking
  - 🥚 Easter Eggs
  - 🙈 .gitignore
  - 📸 Snapshots
  - ⚗️ Experiments
  - 🔍 SEO
  - 🏷️ Types
  - 🌱 Seed Files
  - 🚩 Feature Flags
  - 🥅 Catch Errors
  - 💫 Animations
  - 🗑️ Deprecate Code
  - 🛂 Authorization
  - 🩹 Minor Fixes
  - 🧐 Data Inspection
  - ⚰️ Remove Dead Code
  - 🧪 Failing Test
  - 👔 Business Logic
  - 🩺 Healthcheck
  - 🧱 Infrastructure
  - 🧑‍💻 Dev Experience
  - 💸 Sponsorships
  - 🧵 Multithreading
  - 🦺 Validation

With `git_changie`, you can effortlessly track and categorize changes in your project, making collaboration smoother and more organized! 🌈



## Installation

### From GitHub

You can clone the repository and build it locally:

```bash
git clone https://github.com/Shreemanarjun/git_changie.git
cd git_changie
dart pub get
```
## Activate Globally from `pub.dev`



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
