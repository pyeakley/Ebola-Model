This model was written in NetLogo and R

ODD

Purpose and patterns

The following theoretical model has been designed to help determine the primary modes of transmission for Ebola virus. My hypothesis is that aerosols have little to no effect on disease transmission. To test this, I will be simulating infected patients with direct contact with infected individuals and will be comparing this data to a study (Osterholm et al.) composed of various data regarding disease infection with the same parameters. This model was written in NetLogo and R.


Entities, state variables, and scales

The model contains one entity: people. The people in the model are characterized by their state of infection, i.e. infected or not infected. There is a tracked boolean for each agent that is set to true if they come into direct contact with an infected agent. There is an adjustable initial value for the number of people which are included in the population. There is also an initial value for the starting number of infected individuals that can be adjusted depending on the desired starting value. 

Rationale: People are the only agents in the model. In the original study, the parameters which were recorded were group size, number of those who were ill with direct contact, number of those who were ill with no direct contact, number of those who were not ill with direct contact, and number of those who were not ill with no direct contact. Assuming that there are no air-born or other factors, the variables measured in this model should correlate with previous studies. Otherwise it may show that there are other contributing modes of transmission than what is currently known.


Process overview and schedulings

After the initialization of the world (see below), the following takes place:

 On set-up initialized agents are randomly spread out to starting locations within the world.
After each time-step agents choose a random direction to move in. If an infected agent crosses paths i.e. comes into direct contact with a non-infected agent an event is triggered where a probability is selected from one of the original studies, and based on that interaction the non-infected agent may become infected.
The model will run until each non-infected agent has direct contact with an infected one.

Design Concepts

Basic Principles

This agent-based theoretical model explores transmission of the 2015 Zaire Strain Ebola Virus Disease. By analyzing transmission based solely on direct contact with infected individuals we hope to provide theoretical proof that no other transmission factors have an effect on disease spread.

Emergence

We expect emergence in one main way: infected population ratio. This is the pattern that will come forth after repeated runs of the model, indicated whether or not the infected population ratio correlates with previous studies.

Adaptation

The agents in the model do not have many adaptive traits. They move at random and have no other deciding factors.

Interaction

Interaction is limited to physical contact. Upon contact between all non-infected individuals and infected ones the model will end.

Stochasticity

The initial population’s starting points are completely randomized. The movement decisions of each agent are random. Whether or not agents are infected on contact are also based on values randomly selected from an array.

Observation

Aside from the model window within NetLogo 6.2.0, the ggplot R library was also used in order to view newly generated results within a 95% confidence band created from the data gathered from previous studies.


Initialization

The number of initial agents is based on the user’s selected population size. This has a limit set between 70 and 175. The rationale behind this is that these numbers generally fit within the range of population size of the previously gathered data. The user also selects the number of individuals that are initially infected. This is between 1 and 10. Once selected and set up the agents are scattered randomly throughout the world.


Submodels

There are not any real submodels within the main model. However, R is used in order to graph the data after every run and compare it to previously established results. To do this, the parameters that are taken in consist of the population size as well as the final number of infected individuals. These values are then concatenated with a pre-existing vector, labeled based off of color, and the graphed.


Reference link to original study

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4358015/

