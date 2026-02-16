# ReInviteParty

**Allows automatic conversion of a 5-man raid into a 5-man party, for times you accidentally convert your dungeon party. Compatible with Vanilla and TurtleWoW.**

A lightweight utility addon for raid leaders that automates the conversion of raids back into 5-man parties, with optional status feedback via [CleveRoid](https://github.com/bhhandley/CleveRoidMacros).

---

## **Purpose**

This addon provides a fast recovery solution when a group is accidentally converted into a raid, automating the transition back to a standard 5-man party with minimal disruption.

It also complements raid-based builders such as Tactica. For example, you can use Tactica to form a dungeon group via a Custom Raid (leveraging auto-announce, auto-invite, and role detection), and once five members are finalized, simply use `/reinv` to convert the group cleanly back into a party.

---

## **Features**

- **Simple slash commands**: `/reinviteparty`, `/reinvite`, or `/reinv`  
- **Automatic member storage**: Remembers all current raid members  
- **Sequential invites**: Reinvites members one at a time with controlled intervals to prevent rejection or spam  
- **Raid leader only**: Ensures only the leader can trigger the process  
- **Optional status feedback**: Integrates with CleveRoid for invite progress messages  

---

## **How It Works**

1. Prepare your group in raid mode.  
2. Run `/reinviteparty` (or `/reinvite` / `/reinv`).  
3. The addon will:  
   - Capture all current raid members  
   - Convert the raid into a party  
   - Reinvite members one at a time with safe delays, optionally printing progress via CleveRoid  

---

## **Technical Notes**

- Compatible with Vanilla 1.12 (TurtleWoW-friendly)  
- No external libraries required  
- Relies on CleveRoid for status messages (optional)  
- Uses safe timing to prevent server invite throttling  
- Handles members who are already in the party gracefully  
- Leader-only safeguards prevent accidental execution  

---

## **Requirements**

- Must be raid leader to execute  
- Works for groups up to 5 members (party limit)  

---

## **Perfect For**

- Tactica raid builder transitions  
- Finalizing 5-man dungeon compositions  
- Efficiently recovering from accidental raid conversion  
- Streamlining automation-heavy workflows  

---
