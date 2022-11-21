# SQL_Magist
first Data analysis via MySQL and Tableau

Project presentation https://docs.google.com/presentation/d/1Vz9m9d7cRlTZZqFalEBb4n0k28Onwxd3JZOh10pCs6U/edit#slide=id.g191e34f3329_0_141

# StoryLine
## Eniac The Comapny
Eniac is an online marketplace specializing in Apple-compatible accessories. It was founded 10 years ago in Spain and it has since grown and expanded to other neighboring countries.

Besides offering a wide catalog of products at competitive prices, Eniac provides friendly and professional tech support and consultation to its customers. The warmhearted spirit that thrives with direct contact with the customers is at the roots of the company.

Since the company went public, the investors have been pushing the company to scale up the business and become a big e-commerce player globally. It goes without saying that it is an arduous challenge to do so while retaining the human side of the business, Eniac’s emblem.

Here are some numbers that will help you understand Eniac’s scope (data from April 2017 – March 2018):

Revenue: 40,044,542 €
Avg monthly revenue: 1,011,256 €
Avg order price: 710 €
Avg item price: 540 €

## Eniac Strategy
Eniac is exploring an expansion to the Brazilian market. Data shows that Brazil has an eCommerce revenue similar to that of Spain and Italy: an already huge market with an even bigger potential for growth. The problem for Eniac is the lack of knowledge of such a market. The company doesn’t have ties with local providers, package delivery services, or customer service agencies. Creating these ties and knowing the market would take a lot of time, while the board of directors has demanded the expansion to happen within the next year.

Here comes Magist. Magist is a Brazilian Software as a Service company that offers a centralized order management system to connect small and medium-sized stores with the biggest Brazilian marketplaces. Magist is already a big player and allows small companies to benefit from its economies of scale: it has signed advantageous contracts with the marketplaces and with the Post Office, thus reducing the cost of fees and, most importantly, the bureaucracy involved to get things started.

Eniac sells through its own e-commerce store in Europe, with its own site and direct providers for all the steps of the supply chain. In Brazil, however, Eniac is considering signing a 3-year contract with Magist and operating through external marketplaces as an intermediate step, while it tests the market, creates brand awareness, and explores the option of opening its own Brazilian marketplace.

The economic conditions of the deal are already being discussed. But not everyone in the company is happy moving on with this. There are two main concerns:

Eniac’s catalog is 100% tech products, and heavily based on Apple-compatible accessories. It is not clear that the marketplaces Magist works with are a good place for these high-end tech products.
Among Eniac’s efforts to have happy customers, fast deliveries are key. The delivery fees resulting from Magist’s deal with the public Post Office might be cheap, but at what cost? Are deliveries fast enough?
Thankfully, Magist has allowed Eniac to access a snapshot of their database. The data might have the answer to these concerns. Here’s where you come in: you will be the one exploring Magist’s database. (magist_dump.sql)

# Data File structure
-- magist_dump.sql --> Input DB 
-- magist_basicQuestions --> queries to get used to the DB
-- Is_Magist_Good_Decision.sql --> Queries used to take decision
-- magist_model.mwb --> MySQL WS
-- magist_model.png --> Pic for magist EER Diagram
-- Magist_Tableau.twb --> Magist Tableau WS
