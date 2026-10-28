# Playbook: P1 - Architecture & Deep-Dive

Used for explaining complex technical architectures, data pipelines, schema designs, or major refactorings.

## Architectural Writing Requirements
- **Context First:** Clearly articulate the "before" state and the specific operational, business, or technical pain that forced the change.
- **Options Considered:** Do not just show the winning solution. Detail at least one alternative considered and the concrete trade-off that disqualified it.
- **Grounded Details:** Include schema definitions, data flow steps, API contracts, or code abstractions rather than hand-wavy descriptions.
- **Operational Reality:** Mention edge cases, operational traps, or ongoing monitoring needs. Nothing works perfectly in production.

## Standard Section Pattern
1. **Context & Motivation:** The breaking point of the legacy approach or the new business requirement.
2. **Architecture Overview:** The new model, high-level components, and why it fits.
3. **Deep-Dive into Core Design:** Detailed look at schemas, synchronization, interfaces, or critical code paths.
4. **Trade-offs & Rejected Alternatives:** Why not X, why not Y (e.g., performance vs. consistency, build vs. buy).
5. **Production Lessons / Retrospective:** What worked beautifully, and what remains unsolved or tech debt.
