---
name: c-explore
description: Builds a mental model of a domain by exploring its code, schema, or system.
---

# Domain Exploration

## Usage

`/c-explore <path or topic>`

## Prompt

I want to build a mental model of the domain represented by `$ARGUMENTS`. Explore the relevant code/schema/system and help me understand:

1. **Core nouns (concepts & structure)**
   Identify the key entities, their relationships, and lifecycles (including major states).

2. **Core verbs (workflows & state changes)**
   What operations matter most? Describe the primary workflows and state transitions, including what triggers them.

3. **Boundaries (ownership & contracts)**
   Where does this domain stop and another begin? Call out integration points, external dependencies, and the contracts/interfaces involved.

4. **Invariants (rules & constraints)**
   What must always be true? List constraints the system enforces (or assumes) and why they exist.

5. **Non-obvious bits (gotchas & intent)**
   Highlight subtle design decisions, hidden coupling, overloaded terminology, and anything that would surprise a newcomer. Name recognizable patterns (e.g., outbox, saga) when applicable.

**Guidelines**

* Keep it conceptual: focus on meaning and intent over mechanics.
* Use concrete names from the code/schema, explained in plain language.
* If you're uncertain, label it as a hypothesis and add a question to validate it.
* If the scope is large, start with a high-level domain map and ask where to zoom in next.

**Output format**

* Domain map (1 page-ish)
* Concepts & relationships
* Workflows/state transitions
* Invariants/constraints
* Non-obvious notes
* Open questions (prioritized)
