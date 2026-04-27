# Vivarium

Vivarium is a **simulation / tycoon / strategy** game concept centered on building and managing a living terrarium ecosystem.

## Core Vision

> "Most games give you control. Vivarium gives you influence."

The player does not control creatures directly. Instead, they change environmental conditions and observe how a connected ecosystem responds over time.

## Core Pillars

- **Living Ecosystem**: Food, waste, growth, and decay are interconnected.
- **Player Influence**: Indirect systems-based intervention instead of direct unit control.
- **Balance & Consequences**: Systems can stabilize or collapse based on player decisions.
- **Creative Building**: Players shape a terrarium visually while managing simulation constraints.

## Core Gameplay Loop

1. Build environment (soil, plants, water)
2. Introduce insects
3. Observe behavior
4. Adjust ecosystem (resources and conditions)
5. Evaluate outcomes (growth, imbalance, collapse)
6. Iterate and experiment

## MVP Scope (Critical)

### Included

- 1 biome
- 2–3 insect species
- Core nutrient loop
- Basic environment variables (humidity, temperature, light)
- Simple reproduction and death
- Sandbox mode
- Minimal UI

### Excluded

- Complex genetics
- Multiplayer
- Large-scale ecosystems
- Advanced AI
- Full physics simulation

## Core Simulation Systems

### 1) Nutrient Cycle

- Insects eat → produce waste
- Waste → nutrients
- Nutrients → plant growth
- Plants → food source

### 2) Decomposition

- Dead organisms decay through fungus/bacteria-like processes
- Decay feeds nutrient regeneration
- Over-accumulation creates toxicity risk

### 3) Behavior Rules (Emergent)

Creatures follow simple rules:

- Seek food
- Avoid harmful conditions
- Cluster in favorable zones

### 4) Resource Competition

Finite food, space, and nutrients drive:

- Dominance
- Scarcity pressure
- Local extinction events

### 5) Toxicity / Imbalance

- Waste buildup
- Mold overgrowth
- Environmental mismatch

Can trigger sudden ecosystem collapse.

### 6) Adaptation Lite

- Light population variation
- Environment-influenced survival rates
- Gradual ecosystem shifts over long periods

## Player Interventions

Players can indirectly influence outcomes by:

- Adding/removing species
- Adjusting water/light/temperature
- Altering environmental layout

Each intervention may create delayed side effects.

## Game Structure

- **Primary mode**: Sandbox (no hard win condition)
- **Future mode**: Campaign (guided progression and mechanic onboarding)
- **Future mode**: Arena (simulation stress tests in controlled setups)

## Technical Approach (Prototype)

- **Engine**: Godot (likely)
- **Architecture**: Tick-based, rule-driven simulation
- **Modeling strategy**: Value-based tracking for populations/resources/environment
- **Implementation style**: Modular systems (feeding, environment, reproduction)
- **Prototype priority**: Functionality and loop quality over visuals

## Prototype Success Criteria

A first prototype is successful if it demonstrates:

- A functional, self-updating ecosystem loop
- Observable cause/effect from player interventions
- Engaging watch-and-adjust gameplay

## Open Team Questions

- Grid vs free placement?
- Simulation-heavy vs game-like accessibility?
- Sandbox-only first, or campaign planning early?
- Internal learning vs external development support?
- Hobby pace vs timeline-driven project?

## Future Expansion Directions (Post-MVP)

- More species and richer food webs
- Additional biomes (desert, tropical, swamp)
- Advanced genetics/evolution
- Dynamic disruption events (heat spikes, mold crises)
- Creative customization systems
- Sharing/community features
- Analytics/graphs/insight layer
- Experimental high-risk systems (e.g., rare unstable species market)

## Pitch Short Form

"You build a small ecosystem. At first, it balances itself. Then one small change—like too much humidity—can trigger a chain reaction and collapse everything."

That tension between observation, intervention, and consequence is the heart of **Vivarium**.

## Godot Prototype (Ants)

This repository now includes a runnable Godot 4 prototype with one species (ants).

### What is implemented

- Single species simulation: ants
- Ant behavior: wandering + seeking nearest food
- Core loop slice: food consumption → waste → nutrient conversion → food regrowth
- Basic life cycle: energy drain, reproduction at high energy, death from starvation/age
- Simple sandbox controls:
  - `Space`: add extra food
  - `Backspace`: remove ants
  - `R`: reset simulation

### Run

1. Install Godot 4.x.
2. Import this folder as a project.
3. Run the main scene (`res://scenes/main.tscn`).
