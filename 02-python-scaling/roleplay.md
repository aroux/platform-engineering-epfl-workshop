# Roleplay Scenarios: From Scripts to YAML Provisioning

---

## Scenario 1: The Request Avalanche

**Setup the scene:**

> It's been three weeks since you wrote your Python scripts. Word got out, and now your Slack is a disaster — five messages from the same developer: create this repo, create this group, add these people, give them access. Five separate scripts, in the right order, while they wait.

**The pain:**

> "There's no structure. People tell me things in whatever order they think of them, and I have to piece it together."
>
> "I want one document that describes everything about a project's GitHub setup, and one command to make it real."


---

## Scenario 2: The Permission Puzzle

**Setup the scene:**

> A tech lead rattles off permissions over Slack: aroux is admin, lanzrein gets write, the global admins group needs admin rights too. You write it on a sticky note and run three commands. A week later someone asks who has access to the frontend repo. You have no idea without clicking through GitHub for five minutes.

**The pain:**

> "Permissions live in five different places in the GitHub UI. I never have the full picture in one place."
>
> "When someone leaves, I have to remember everywhere they were added. I always miss something."



---

## Scenario 3: The Compliance Wake-Up Call

**Setup the scene:**

> An enterprise client sends a security questionnaire: do you require PR reviews before merging to main? You check your repos. Some have 1 required reviewer, some have 2, one has none. Nobody knows when or why.

**The pain:**

> "Every repo has different branch protection because each one was set up manually by a different person."
>
> "New repos don't automatically get the right rules. Someone always forgets."


---

## Scenario 4: The Python Parser

**Setup the scene:**

> The YAML file is a hit — but you're still manually translating it into commands. Your colleague is out sick, someone hands you their YAML, and you run things in the wrong order. You try to add a group to a repo before the group exists. Error. You fix it, re-run, and now you're not sure what was already applied and what wasn't.

**The pain:**

> "I'm still the parser. I'm reading the file and running commands by hand. If I'm out, nobody else knows the order."
>
> "I want to hand someone a YAML and a single command"

