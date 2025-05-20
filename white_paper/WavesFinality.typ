#import "@preview/charged-ieee:0.1.3": ieee
#import "@preview/drafting:0.2.2": inline-note, note-outline

#let todo=inline-note.with(rect: rect.with(inset: 1em, radius: 0.5em), fill: orange.lighten(80%))

#show: ieee.with(
  title: [Improving Finality in Waves: Protocol Enhancements and Guarantees],
  abstract: [
    Fast finality is a key advantage of modern blockchains, as the user experience is directly affected by how quickly blocks are finalized.  
    In this paper, we present enhancements to the Waves Proof-of-Stake protocol that improve finality by leveraging the voting power of balances actively validating blocks but not currently generating them.  
    We introduce the design of a new finality protocol, demonstrate its desirable properties, and analyze its resilience against common attacks and prolonged network forks.
  ],
  authors: (
    (
      name: "Alexey Kiselev",
      organization: [Waves Foundation],
      email: "akiselev@uniqsoft.ae"
    ),
    (
      name: "Sasha Ivanov",
      organization: [Waves Foundation],
      email: ""
    ),
  ),
  index-terms: ("Waves Blockchain", "Proof-Of-Stake", "PoS", "Finality"),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

#note-outline()

= Introduction

Finality is a fundamental concept in blockchain systems, offering assurance that a transaction will not be reversed once confirmed.
While Waves achieves high throughput and short block times, it currently lacks a formal mechanism to determine when blocks become final.
This leads to uncertainty for users, developers, and systems integrating with Waves, particularly in contexts that demand strong safety guarantees.

This paper addresses this gap by introducing an enhancement to the Waves Proof-of-Stake protocol.
Our approach leverages validator commitments and endorsements to track block support over time, enabling deterministic finality based on measurable consensus thresholds.

We formally specify the protocol, analyze its desirable properties, and evaluate its behavior under adversarial conditions.
Our findings show that the enhanced finality model improves robustness against forks and enables practical guarantees for irreversible state transitions.


== Motivation

The emergence of BFT-style consensus protocols has demonstrated that fast finality is achievable, but often at the cost of liveness.
In contrast, classical Proof-of-Stake blockchains like Waves prioritize continuous block production and network responsiveness, avoiding the trade-off of halting in uncertain conditions.
Nevertheless, achieving fast and reliable finality remains a highly desirable goal.

In this paper, we demonstrate that it is possible to attain both: strong finality guarantees without compromising the liveness properties of the Waves blockchain.


== Overview of Finality in Blockchains

#todo[Describe finality models in classical blockchains and BFT-based blockchains.]

== Finality Challenges in Waves

#todo[Explain why calculating finality in the current Waves protocol is difficult.]

= Background

Waves operates as a classic Proof-of-Stake (PoS) blockchain, where blocks are considered final once the cumulative balance of generators confirming them exceeds 50% of the total balance of all generators.
At this point, no set of generators can create an alternative chain of blocks without surpassing this majority threshold.

Block confirmation occurs when other generators append their blocks on top of a given block, effectively endorsing it.


== Overview of Waves Proof-of-Stake Protocol

#todo[Brief introduction to the current Waves PoS protocol with references to white papers.]

== Current Finality Mechanism

However, under the current Waves consensus, only the total supply of Waves is known. It is possible to calculate the cumulative balance of accounts exceeding the minimum threshold required to become a generator.
Nevertheless, it is impossible to predict the exact cumulative balance of the generators actively competing to produce a block at any given moment.

As a result, the finality of the Waves blockchain has a probabilistic nature. There is always a possibility for a hidden group of generators, with a cumulative balance larger than that of the active generators, to form.
Such a group could potentially create an alternative chain. Upon presenting this chain, existing generators would be forced to accept it, leading to a reorganization of the blockchain.

To mitigate this, we propose forming an Explicit Set of Generators.


= Design Goals

#todo[Describe the objectives of the protocol additions and the components that need to be designed.]

== Fast and Predictable Finality
#todo[Describe our vision for achieving fast finality on the Waves blockchain.]

== Security and Fork Resistance
#todo[Explain why it is essential to maintain the current level of liveness and avoid introducing new vulnerabilities.]

== Incentive Compatibility
#todo[Describe the impact on generator incentives.]

== Backward Compatibility
#todo[Discuss the ability to operate without finality enhancements and the option to revert to the current consensus without issues.]

= Protocol Enhancements
#todo[Provide an overview of all proposed enhancements.]

== Generation Commitment Transactions
#todo[Describe the new transaction type.]

== Endorsement Mechanism
#todo[Describe the endorsement mechanism used by validators.]

== Active Generator Set Tracking
#todo[Describe how the generator set is formed and operates.]

== Finality Threshold and Voting Rules
#todo[Describe the parameters of the new finality mechanism.]

= Specification
#todo[Provide an overview of the implementation components and general implementation notes.]

== Generation Commitment Transaction
#todo[Describe the new transaction type and its validation rules.]

== Endorsement Network Message
#todo[Describe the endorsement message format and its validation process.]

== Block and Microblock Structure Updates
#todo[Describe the additions to block and microblock structures and how backward compatibility is maintained.]

== Generator Set Tracker
#todo[Describe the implementation details of the Generator Set.]


= Security Analysis
#todo[Provide an overview of security issues introduced by the protocol enhancements.]

== Handling Network Splits
#todo[Describe the model of the network split scenario and describe the outcomes.]

== Attack Scenarios and Mitigations
#todo[List possible attacks and explain the corresponding design decisions made to mitigate them.]

= Simulation and Evaluation
#todo[Provide an overview of the finality simulation.]

== Simulation Setup and Parameters
#todo[Describe the simulation software and include links to the repositories.]

== Finality Time Model
#todo[Summarize the outcomes of the modeling.]


= Conclusion and Future Work

== Summary of Results
#todo[Write the concluding summary of the paper.]

== Roadmap for Deployment
#todo[Outline the development and deployment roadmap.]
