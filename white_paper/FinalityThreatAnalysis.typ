#set page(
  paper: "a4",
  header: align(right)[Finality Threat Analysis],
  numbering: "1",
  number-align: center,
)
#set heading(numbering: "1.")

= Finality Threat Analysis

This section outlines key threats to the finality mechanism, prioritized by severity:

- Passive Commitment Attack
- Commitment Flooding
- Endorsement Censorship
- Self-Endorsement Domination
- Commitment Flip-Flopping

For each threat, potential mitigation techniques are identified and evaluated.

== Passive Commitment Attack

In this attack, a large balance holder submits a Generation Commitment Transaction to participate in block generation and validation but deliberately refrains from endorsing blocks.
This behavior disrupts finality by inflating the quorum denominator without contributing to endorsement weight.

=== Possible Mitigations

+ *Validator Liveness Tracking*: Track the number of validated (endorsed) blocks for each committed validator. Exclude consistently inactive validators from the active generator set. The exclusion threshold may depend on both balance and activity, for example, accounts with larger balances are allowed to skip fewer blocks before being removed.
+ *Commitment Deposit Slashing*: Penalize inactive validators by reducing their commitment deposit in proportion to their validation inactivity. This discourages passive participation and encourages active contribution to finality.


== Commitment Flooding

An attacker with a large amount of Waves may attempt to overwhelm the network by splitting their balance across thousands of accounts and submitting Generation Commitment Transactions from each, without any intention to generate or validate blocks.

This behavior leads to:
- Increased load on tracking the generators set.
- Performance degradation during generators set verification for each block.
- Potential denial-of-service (DoS) on data structures related to the generators set.

=== Possible Mitigations

+ *Raise the Minimum Generation Balance Threshold*

Currently, the minimum generation balance is 1,000 Waves. Increasing this threshold to 10,000 Waves would reduce the number of potentially abusive accounts to a manageable level.

> Note: Generation balance does not affect the ability to validate blocks. Every committed validator is expected to endorse every new block during their commitment period.

+ *Introduce a Non-Trivial Fee for Generation Commitment Transactions*

Introduce a balance-dependent fee model, where lower-balance commitments require proportionally higher fees. For example, a 1M Waves commitment might require a 1 Waves fee, whereas a 1K Waves commitment could incur a 1000 Waves fee.  
The fee may be refundable in cases of active and honest participation, but burned if the account fails to generate or validate blocks.

+ *Introduce a Cap on the Generator Set Size*

Impose a hard limit on the number of active generators per block — for example, allow only the top 100 generators (by balance) to participate in block validation.  
More sophisticated prioritization can be introduced, such as using the number of successful generation epochs as a secondary sorting criterion.

== Endorsement Censorship

An attacker withholds endorsements from other validators when producing a block, preventing the block from collecting enough endorsements to finalize.  
However, this is not considered a serious attack, as the next block produced by another generator can effectively finalize the entire chain retroactively.

=== Possible Mitigations

+ *Penalize Blocks Without Endorsements When a Generator Set Exists*

If the generator set is not empty and includes other active generators, but a block is produced without any endorsements, the generator of such a block should be penalized.  
Specifically, the generator could be removed from the active generator set or subjected to other slashing mechanisms.


== Self-Endorsement Domination

A network of generators endorses only blocks produced by member nodes, while withholding endorsements from other validators.  
This attack can be viewed as an attack on the slashing mechanism of Waves Finality: if the network is large enough and censorship is significant, it could lead to the slashing of honest generators who are not part of the network.

=== Possible Mitigations

+ *Reset Validator Rating Upon Inclusion*

The attacking network cannot produce blocks indefinitely without external endorsements.  
Therefore, when a block produced by a non-member includes endorsements from previously censored validators, their rating should be effectively reset.  
This prevents long-term penalization of validators who were victims of targeted censorship.

== Commitment Flip-Flopping

An attacker attempts to repeatedly commit and revoke their Generation Commitment to destabilize the generator set.

However, this attack is not possible because Generation Commitment Transactions are irrevocable and can only expire after the completion of the commitment period.
