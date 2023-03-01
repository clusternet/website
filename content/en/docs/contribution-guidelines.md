---
title: "Contributing"
description: "Clusternet contributing guide"
date: 2022-01-17
draft: false
weight: 11
---

Welcome to Clusternet!

First off, thanks for taking the time to contribute!
To learn more about contributing to the code repo, check out the [Developer Guide](/docs/developer-guide/).

The following is a set of guidelines for contributing to Clusternet. These are just guidelines, not rules.
Use your best judgment, and feel free to propose changes to this document in a pull request.

## Communication

We use Slack, Email and Google Group to communicate about the project.

- Join our Slack channel `#clusternet` hosted at [CNCF Slack](https://cloud-native.slack.com/) and introduce
  yourself. This is a great place to ask questions, discuss ideas, and get feedback.
- You can send us emails via [mailing list](mailto:clusternet@googlegroups.com) to report any critical/security issues,
  ask for help, discuss features, etc.
- [Clusternet Google Group](https://groups.google.com/g/clusternet) is another way to learn what's happening in the
  Clusternt community.

You can also just [open a github issue](https://github.com/clusternet/clusternet/issues/new/choose) to start the
discussions.

## Issue Tracker

We use [Github Issues](https://github.com/clusternet/clusternet/issues) to track issues and feature requests. Please
check the issue tracker before starting work on a new feature or bug fix. If you find an issue that you would like
to work on, assign yourself to the issue and leave a comment saying that you are working on it.

## Pull Requests

Contributions should be made via [pull requests](https://github.com/clusternet/clusternet/pulls).
Pull requests will be reviewed by one or more maintainers and merged when acceptable.

Before presenting code changes via a PR, it is recommended to first submit an issue. This issue can include a problem
statement and a checklist with requirements. If solutions are proposed, alternatives should be listed and eliminated.
Even if the criteria for elimination of a solution is frivolous, say so.

For large or high impact PRs, it is strongly suggested to coordinate with the maintainers. This will prevent you from
doing extra work that may or may not be merged.

## Commit Messages

Please write clear and concise commit messages that describe the changes you have made. Your commit messages should be
written in the present tense and should start with a verb. For example:

- "Add new feature to..."
- "Fix bug in..."
- "Update documentation for..."

Your commit messages should also include the issue number (if applicable) and a brief description of the changes.
For example:

- "Fix bug in login form (#123)"
- "Update README with new instructions (#456)"
- "Add new feature to dashboard (#789)"

If you're lost about what this even means, please see [How to Write a Git
Commit Message](http://chris.beams.io/posts/git-commit/) for a start.

In practice, the best approach to maintaining a nice commit message is to leverage a `git add -p` and
`git commit --amend` to formulate a solid changeset. This allows one to piece together a change, as information becomes
available.

When making a commit with co-authors, please use `Co-authored-by` to indicate each person who contributed to the PR.
This enables automated tools and
[Github](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors)
to highlight everyone's role in the PR.

## Sign your work

The sign-off is a simple line at the end of the explanation for the patch. Your signature certifies that you wrote the
patch or otherwise have the right to pass it on as an open-source patch. The rules are pretty simple that you can
certify from [developercertificate.org](http://developercertificate.org/).

You just add a line to every git commit message:

> Signed-off-by: Joe Smith <joe.smith@email.com>

Use your real name (sorry, no pseudonyms or anonymous contributions.)

If you set your `user.name` and `user.email` git configs, you can sign your commit automatically with `git commit -s`.

## Code of Conduct

Clusternet follows the [CNCF Code of Conduct](https://github.com/cncf/foundation/blob/master/code-of-conduct.md).
Please make sure your code adheres to these conducts.
