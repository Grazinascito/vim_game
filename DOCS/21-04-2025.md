# Today I Learned (TIL)

**Date:** YYYY-MM-DD

**Topic:** [Be brief and descriptive, e.g.: Flutter RawKeyboardListener Focus, Difference between setState vs Cubit, Basic Strategy Pattern]

---

### What I Learned:

*   [Describe here the main discovery, insight, or understanding. Try to be specific.]
*   [You can add more points if there are multiple related learnings.]
*   [If it’s code-related, you can include a small snippet or a link to the relevant commit/file.]

```markdown
// Example code, if applicable
final FocusNode _focusNode = FocusNode();
// ...
RawKeyboardListener(
  focusNode: _focusNode, // Needs a FocusNode!
  onKey: _handleKeyEvent,
  child: //...
)
