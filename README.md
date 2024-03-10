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

### Stash

### Git rebase

**Goal**: replies commits on top of the new base.

`git log --oneline --graph --all`

```
* ffccf53 (HEAD -> my-feature) feat: add my-new-file.txt
| * 619d012 (master) chore: add README.md
|/  
* 2d8cee5 feat: add world.txt
* 9c69f5f feat: add hello.txt
* 981842e add gitignore
```

```mermaid
gitGraph
  commit id: "981842e"
  commit id: "9c69f5f"
  commit id: "2d8cee5"
  branch my-feature
  commit id: "ffccf53"
  checkout main
  commit id: "619d012"
``` 

`git checkout my-feature && git rebase master`

```
* d8d174a (HEAD -> my-feature) feat: add my-new-file.txt
* 619d012 (master) chore: add README.md
* 2d8cee5 feat: add world.txt
* 9c69f5f feat: add hello.txt
* 981842e add gitignore <-- NEW HASH <=> NEW COMMIT
```

```mermaid
gitGraph
  commit id: "981842e"
  commit id: "9c69f5f"
  commit id: "2d8cee5"
  commit id: "619d012"
  branch my-feature
  commit id: "d8d174a"
```

`git checkout master && git merge my-feature`

Using fast-forward merge, the history will be linear:

```
Updating 619d012..d8d174a
Fast-forward
```

```
* d8d174a (HEAD -> master, my-feature) feat: add my-new-file.txt
* 619d012 chore: add README.md
* 2d8cee5 feat: add world.txt
* 9c69f5f feat: add hello.txt
* 981842e add gitignore
```

```mermaid
gitGraph
  commit id: "981842e"
  commit id: "9c69f5f"
  commit id: "2d8cee5"
  commit id: "619d012"
  commit id: "d8d174a"
```

#### Advanced

```
* 0420b89 (HEAD -> client) feat: add index.html
* 53af2e6 chore: prepare frontend folder
| * e786d27 (server) chore: prepare backend folder
|/  
* 6012aa3 (develop) chore: prepare web app folder
| * d8d174a (master) feat: add my-new-file.txt
| * 619d012 chore: add README.md
|/  
* 2d8cee5 feat: add world.txt
* 9c69f5f feat: add hello.txt
* 981842e add gitignore
```

```mermaid
gitGraph
  commit id: "981842e"
  commit id: "9c69f5f"
  commit id: "2d8cee5"
  branch develop
  commit id: "6012aa3"
  branch server
  commit id: "e786d27"
  checkout main
  commit id: "619d012"
  commit id: "d8d174a"
  checkout develop
  branch client
  commit id: "53af2e6"
  commit id: "0420b89"
```

We want to rebase `client` on top of `develop`:

`git rebase --onto master server client`

```
* b706407 (HEAD -> client) feat: add index.html
* ac7ceb7 chore: prepare frontend folder
* d8d174a (master) feat: add my-new-file.txt
* 619d012 chore: add README.md
| * e786d27 (server) chore: prepare backend folder
| * 6012aa3 (develop) chore: prepare web app folder
|/  
* 2d8cee5 feat: add world.txt
* 9c69f5f feat: add hello.txt
* 981842e add gitignore
```

```mermaid
gitGraph
  commit id: "981842e"
  commit id: "9c69f5f"
  commit id: "2d8cee5"
  branch develop
  commit id: "6012aa3"
  branch server
  commit id: "e786d27"
  checkout main
  commit id: "619d012"
  commit id: "d8d174a"
  checkout develop
  checkout main
  commit id: "ac7ceb7"
  commit id: "b706407"
```
