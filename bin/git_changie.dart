import 'dart:io';

import 'package:pubspec_yaml/pubspec_yaml.dart';

// Print usage instructions
void printUsage() async {
  final pubspecYaml = File('pubspec.yaml').readAsStringSync().toPubspecYaml();
  final version = pubspecYaml.version;
  print('''
Usage: dart run changelog.dart [options]

Options:
  --hash              Include commit hash
  --author            Include commit author
  --date              Include commit date
  --from-tag <tag>    Generate changelog starting from this tag
  --to-tag <tag>      Generate changelog up to this tag (inclusive)
  --since <date>      Generate changelog starting from this date (YYYY-MM-DD)
  --until <date>      Generate changelog up to this date (YYYY-MM-DD)
  --output <file>     Specify output file (default: CHANGELOG.md)
  --add-category <name>  Add a custom category if needed.
  --help              Show this help message

  version ${version.unsafe}
''');
}

// Updated emoji categories
final Map<String, String> emojiCategories = {
  '🎨': 'Style',
  '⚡️': 'Performance',
  '🔥': 'Remove',
  '🐛': 'Fixes',
  '🚑': 'Critical Hotfix',
  '✨': 'Features',
  '📝': 'Documentation',
  '🚀': 'Deployment',
  '💄': 'UI Changes',
  '🎉': 'Initial Commit',
  '✅': 'Tests',
  '🔒️': 'Security',
  '🔐': 'Secrets',
  '🔖': 'Release Tags',
  '🚨': 'Warnings',
  '🚧': 'Work In Progress',
  '💚': 'CI Build',
  '⬇️': 'Downgrade',
  '⬆️': 'Upgrade',
  '📌': 'Pin Dependencies',
  '👷': 'CI System',
  '📈': 'Analytics',
  '♻️': 'Refactor',
  '➕': 'Add Dependency',
  '➖': 'Remove Dependency',
  '🔧': 'Configuration',
  '🔨': 'Development Scripts',
  '🌐': 'Internationalization',
  '✏️': 'Typos',
  '💩': 'Bad Code',
  '⏪': 'Revert',
  '🔀': 'Merge',
  '📦': 'Compiled Files',
  '👽️': 'API Changes',
  '🚚': 'Move/Rename Resources',
  '📄': 'License',
  '💥': 'Breaking Changes',
  '🍱': 'Assets',
  '♿️': 'Accessibility',
  '💡': 'Comments',
  '🍻': 'Drunken Code',
  '💬': 'Text Changes',
  '🗃️': 'Database Changes',
  '🔊': 'Logs',
  '🔇': 'Remove Logs',
  '👥': 'Contributors',
  '🚸': 'User Experience',
  '🏗️': 'Architectural Changes',
  '📱': 'Responsive Design',
  '🤡': 'Mocking',
  '🥚': 'Easter Eggs',
  '🙈': '.gitignore',
  '📸': 'Snapshots',
  '⚗️': 'Experiments',
  '🔍': 'SEO',
  '🏷️': 'Types',
  '🌱': 'Seed Files',
  '🚩': 'Feature Flags',
  '🥅': 'Catch Errors',
  '💫': 'Animations',
  '🗑️': 'Deprecate Code',
  '🛂': 'Authorization',
  '🩹': 'Minor Fixes',
  '🧐': 'Data Inspection',
  '⚰️': 'Remove Dead Code',
  '🧪': 'Failing Test',
  '👔': 'Business Logic',
  '🩺': 'Healthcheck',
  '🧱': 'Infrastructure',
  '🧑‍💻': 'Dev Experience',
  '💸': 'Sponsorships',
  '🧵': 'Multithreading',
  '🦺': 'Validation',
};

// Main function
Future<void> main(List<String> arguments) async {
  if (arguments.contains('--help')) {
    printUsage();
    exit(0);
  }

  // Determine output file
  String outputFile = _getOutputFile(arguments);

  // Handle additional categories
  List<String> additionalCategories = _getAdditionalCategories(arguments);

  // Check if the file exists and handle accordingly
  bool append = await _checkFileExistence(outputFile);

  // Build Git log format string based on passed arguments.
  String format = _buildGitLogFormat(arguments);

  // Initialize git log arguments
  List<String> gitArgs = _buildGitLogArguments(arguments, format);

  // Run the git log command and handle errors
  String changelog = await _runGitLog(gitArgs);

  // Categorize based on emojis
  Map<String, List<String>> categorizedEntries =
      _categorizeEntries(changelog, additionalCategories);

  // Prepare and write the final changelog content
  await _writeChangelogToFile(categorizedEntries, outputFile, append);
}

// Function to get output file from arguments
String _getOutputFile(List<String> arguments) {
  String outputFile = 'CHANGELOG.md';
  int outputIndex = arguments.indexOf('--output');
  if (outputIndex != -1 && outputIndex + 1 < arguments.length) {
    outputFile = arguments[outputIndex + 1];
  }
  return outputFile;
}

// Function to get additional categories from arguments
List<String> _getAdditionalCategories(List<String> arguments) {
  List<String> additionalCategories = [];
  int customCategoryIndex = arguments.indexOf('--add-category');
  while (
      customCategoryIndex != -1 && customCategoryIndex + 1 < arguments.length) {
    additionalCategories.add(arguments[customCategoryIndex + 1]);
    customCategoryIndex =
        arguments.indexOf('--add-category', customCategoryIndex + 2);
  }
  return additionalCategories;
}

// Function to check if the output file exists
Future<bool> _checkFileExistence(String outputFile) async {
  final file = File(outputFile);
  bool append = false;

  if (file.existsSync()) {
    // Create a backup of the existing changelog
    String backupFileName =
        'CHANGELOG_backup_${DateTime.now().millisecondsSinceEpoch}.md';
    await file.copy(backupFileName);
    print('Backup of the existing changelog created: $backupFileName');

    // Ask if the user wants to append or overwrite
    print(
        'The file "$outputFile" already exists. Do you want to append to it or overwrite it? (a = append, o = overwrite)');
    String? choice = stdin.readLineSync()?.trim().toLowerCase();

    if (choice != 'a' && choice != 'o') {
      print('Invalid choice. Exiting.');
      exit(1);
    }

    append = choice == 'a';
  }
  return append;
}

// Function to build the Git log format string
String _buildGitLogFormat(List<String> arguments) {
  List<String> formatParts = [];
  if (arguments.contains('--hash')) {
    formatParts.add('%h'); // Commit hash
  }
  formatParts.add('%s'); // Commit message
  if (arguments.contains('--author')) {
    formatParts.add('(%an)'); // Author name
  }
  if (arguments.contains('--date')) {
    formatParts.add('[%ad]'); // Commit date
  }
  return formatParts.join(' - ');
}

// Function to build the Git log arguments
List<String> _buildGitLogArguments(List<String> arguments, String format) {
  List<String> gitArgs = ['log', '--pretty=format:$format', '--date=short'];

  // Add filtering by tag
  int fromTagIndex = arguments.indexOf('--from-tag');
  int toTagIndex = arguments.indexOf('--to-tag');

  if (fromTagIndex != -1 && fromTagIndex + 1 < arguments.length) {
    String fromTag = arguments[fromTagIndex + 1];
    gitArgs.add('$fromTag..HEAD'); // Start from tag to the latest commit (HEAD)
  }

  if (toTagIndex != -1 && toTagIndex + 1 < arguments.length) {
    String toTag = arguments[toTagIndex + 1];
    gitArgs[gitArgs.length - 1] = toTag; // Restrict to a specific ending tag
  }

  // Add filtering by date
  int sinceIndex = arguments.indexOf('--since');
  int untilIndex = arguments.indexOf('--until');

  if (sinceIndex != -1 && sinceIndex + 1 < arguments.length) {
    String sinceDate = arguments[sinceIndex + 1];
    gitArgs.add('--since=$sinceDate');
  }

  if (untilIndex != -1 && untilIndex + 1 < arguments.length) {
    String untilDate = arguments[untilIndex + 1];
    gitArgs.add('--until=$untilDate');
  }

  return gitArgs;
}

// Function to run the git log command
Future<String> _runGitLog(List<String> gitArgs) async {
  final result = await Process.run('git', gitArgs);

  if (result.exitCode != 0) {
    stderr.writeln('Error running git log: ${result.stderr}');
    exit(result.exitCode);
  }

  return result.stdout as String;
}

// Function to categorize entries based on emojis
Map<String, List<String>> _categorizeEntries(
    String changelog, List<String> additionalCategories) {
  Map<String, List<String>> categorizedEntries = {};

  // Initialize categories
  for (var category in emojiCategories.values) {
    categorizedEntries[category] = [];
  }

  // Add additional categories
  for (var customCategory in additionalCategories) {
    categorizedEntries.putIfAbsent(customCategory, () => []);
  }

  List<String> logEntries = changelog.split('\n');
  for (String entry in logEntries) {
    if (entry.trim().isEmpty) continue;

    String category = 'Uncategorized';
    for (var emoji in emojiCategories.keys) {
      if (entry.contains(emoji)) {
        category = emojiCategories[emoji]!;
        break;
      }
    }

    // If the category is not found, try to find a custom category
    if (category == 'Uncategorized') {
      for (var customCategory in additionalCategories) {
        if (entry.contains(customCategory)) {
          category = customCategory;
          break;
        }
      }
    }

    categorizedEntries.putIfAbsent(category, () => []).add(entry);
  }

  return categorizedEntries;
}

// Function to prepare and write the final changelog content
Future<void> _writeChangelogToFile(Map<String, List<String>> categorizedEntries,
    String outputFile, bool append) async {
  String categorizedChangelog = '# Changelog\n\n';
  categorizedEntries.forEach((category, entries) {
    if (entries.isNotEmpty) {
      categorizedChangelog += '## $category\n'; // Header for each category
      for (String entry in entries) {
        categorizedChangelog += ' - $entry\n'; // Bullet points for entries
      }
      categorizedChangelog += '\n'; // New line after each category section
    }
  });

  final file = File(outputFile);
  try {
    if (append) {
      await file.writeAsString(categorizedChangelog, mode: FileMode.append);
      print('\nChangelog has been appended to $outputFile');
    } else {
      await file.writeAsString(categorizedChangelog);
      print('\nChangelog has been saved to $outputFile');
    }
  } catch (e) {
    stderr.writeln('Error writing to file: $e');
    exit(1);
  }
}
