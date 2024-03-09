# Automation examples

This repo contains examples of automation and Software Engineering practices, just to experiment and learn.

## Git

### Tagging

[[Ref](https://git-scm.com/book/en/v2/Git-Basics-Tagging)]

- lightweight tag
  - `git tag 'just-a-label'`
  - detached mode
  - `git describe` only look for annotated tags:
    ```
    fatal: No annotated tags can describe 'a3b03454e26a4f45248b9b33dd98b0cf7311945c'.
    However, there were unannotated tags: try --tags.
    ```
  - `git describe --tags` will look for both annotated and lightweight tags
- annotated tag
  - `git tag -a 'v0.0.1'` with a commit message
  - `git describe`
    ```
    v0.0.1-1-ga3b0345
           ^   ^^^^
           |   hash
           |
           |-- how many commits since the tag
    ```
- tags are not pushed
  - `git push origin v0.0.1` to push a single tag
  - `git push --tags` to push all tags (annotated and lightweight)
  - `git push --follow-tags` to push commits and annotated tags

### Signing

- `git config --global tag.gpgSign`
- [https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)
- [https://gist.github.com/paolocarrasco/18ca8fe6e63490ae1be23e84a7039374?permalink_comment_id=3767413#gistcomment-3767413](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

