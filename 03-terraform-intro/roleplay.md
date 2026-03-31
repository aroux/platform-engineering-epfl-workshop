# Roleplay Scenarios: Why Terraform?

*For the presenter: Each scenario is a story to tell. Set up the situation,
let participants feel the pain, then show how Terraform solves it.*

---

## Scenario 1: The Careful Changer

**Setup the scene:**

> You're a platform engineer. A developer asks you to enable the wiki on a
> repository. Simple enough -- but you've been burned before.
>
> Last time you changed a setting through the UI, you accidentally toggled the
> wrong checkbox and broke branch protection. Nobody noticed for a week until
> someone pushed directly to main. Production went down. The post-mortem was
> embarrassing.

**The pain:**

> "I clicked one checkbox and broke production. Now I triple-check everything
> before I touch the UI, but I still can't be sure I didn't miss something."
>
> "I want to see exactly what will change BEFORE it happens. No surprises."


---

## Scenario 2: The Drift Detective

**Setup the scene:**

> It's Monday morning. A colleague messages you:
>
> *"Hey, I turned off branch protection on the demo repo last Friday because it
> was blocking my urgent fix. Can you turn it back on?"*
>
> But wait -- which settings exactly? Required reviewers? Dismiss stale
> reviews? Force push allowed? They don't remember.
>
> You check the repo. Actually, three other repos also have weird settings now.
> Who changed those? When? Nobody knows.

**The pain:**

> "Someone changed something somewhere. I have 50 repositories. I spent three
> hours clicking through settings pages trying to find what's different."
>
> "Last month we failed a security audit because branch protection was off on
> a repo. Nobody knew when it happened or who did it."
>
> "I need to know what changed and get back to my desired state."

---

## Scenario 3: The Time Traveler

**Setup the scene:**

> Your team deployed a configuration change on Friday. On Monday, users report
> issues -- something broke.
>
> "What were the settings before?" Nobody remembers. The GitHub UI doesn't have
> a history. You're scrolling through chat messages trying to find screenshots
> someone might have taken. You find one, but it's blurry and only shows half
> the settings page.

**The pain:**

> "We spent four hours trying to figure out what the settings were before.
> Eventually we just guessed and hoped for the best."
>
> "The fix was easy -- if only we knew what to fix. The detective work was the
> hard part."
>
> "I want to go back to how things were. Quickly and confidently."


---

## Scenario 4: The Declarative Dreamer

**Setup the scene:**

> A colleague proudly shows you their bash script to set up repositories:
>
> ```bash
> gh repo create my-repo --public
> gh api repos/owner/my-repo/branches/main/protection -X PUT ...
> gh label create bug --repo owner/my-repo
> # ... 50 more lines
> ```
>
> "It works great!" they say. Then they run it again. It fails: "repository
> already exists". They run it after a partial failure -- labels exist but
> branch protection doesn't. Now they have no idea what state things are in.
> They start adding `|| true` to every line. The script becomes unreadable.

**The pain:**

> "The script worked once. Then I had to add a label. I re-ran it. Now half
> my repos have the new label and half don't, and I can't tell which is which."
>
> "My setup script is 200 lines of bash with `if` statements checking if
> things exist before creating them. It's a nightmare to maintain. And it
> still breaks."
>
> "I want to describe WHAT I want, not write procedural steps for HOW to get
> there."


---

## Scenario 5: The Dependency Juggler

**Setup the scene:**

> Setting up a repository has dependencies:
>
> 1. Create the repo
> 2. Wait for the default branch to exist
> 3. Set up branch protection (needs the branch)
> 4. Add files (needs the repo)
>
> Your colleague's bash script has `sleep 5` statements and retry loops
> everywhere. "Sometimes GitHub is slow," they explain. It works on their
> laptop. It fails in CI. They bump the sleep to 10 seconds. Now it's slow
> AND unreliable.

**The pain:**

> "The script works 80% of the time. The other 20%, I re-run it and pray."
>
> "I added a new step and now everything breaks because I put it in the wrong
> place. I didn't realize it depended on three other things."
>
> "I don't want to manage ordering and dependencies manually."


---

## Scenario 6: The State Inspector

**Setup the scene:**

> Something seems off with your repository. Did that last apply actually work?
> What does Terraform think the current state is? A colleague asks "what's the
> clone URL for that repo?" You could go to GitHub and click around. Or...

**The pain:**

> "I set up 20 repos last month. Now someone asks me for a list of all the
> URLs. I have to click through each one and copy-paste into a spreadsheet."
>
> "Is that repo public or private? Let me go check... actually, let me check
> all of them. This is going to take a while."
>
> "I want to inspect what Terraform knows about my infrastructure."

