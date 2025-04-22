#set page(
  paper: "a4",
  header: align(right)[Develoment Plan],
  numbering: "1",
  number-align: center,
)
#set heading(numbering: "1.")

= Development Plan

The following components must be implemented.

== Generation Commitment Transaction

The new type of transaction have to be implemented. The Generation Commitment Transaction consists of the following fields:
A new transaction type Generation Commitment Transaction must be introduced.
It consists of the following fields:
- *Version* — the version of the transaction, e.g., 1.
- *Generation Period Start* — the block height at which the generation period starts.
- *Sender Public Key* — the public key of the sender.
- *Timestamp* — the timestamp of the transaction.
- *Fee* — the transaction fee, which must be paid exclusively in Waves.

The transaction ID is calculated as the hash of all transaction fields.

== Endorsement Network Message

A new Endorsement Network Message must be introduced.  
It consists of the following fields:
- *Generator Public Key* — the public key of the block generator.
- *Endorsed Block ID* — the hash of the endorsed block.
- *Endorsed Block Height* — the height of the endorsed block.
- *Endorsement Signature* — the signature confirming the endorsement.

== Updated Micro-block

The structure of the Micro-block must be updated to include the set of block endorsements collected and valid at the time of the micro-block's creation.

== Updated Block

The Block structure must be updated to include the set of valid endorsements.

== Generation Commitment Transaction Validation

Each Generation Commitment Transaction must be validated against the following rules:

- The fee amount must be greater than or equal to the minimal required fee.
- Only one Generation Commitment Transaction from a unique generator is allowed per generation period.
- A Generation Commitment Transaction can only be created for the current or upcoming generation periods.


== Generators Set Tracker

Logic to track the current Generators Set must be implemented.

The Generators Set is updated every block.  
To be included in the Generators Set, a generator must comply with the following rules:

- A Generation Commitment Transaction for the current generation period must be active for the generator.
- The generator must have the required generation balance at the beginning of the block.

The Generators Set Tracker updates the set of active generators and calculates the total generation balance for the current block.

== Finality Tracker

The Finality Tracker collects Block Endorsements from active generators and marks a block as final when the total endorsement balance reaches the required threshold.  
The Finality Tracker prohibits rollback of finalized blocks and provides a public API to check the finality status of a block.

