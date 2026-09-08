# 💊 Pharmacy Performance & Stock Decision Analytics

> An end-to-end business analytics project using **Python, MySQL, Power BI and DAX** to transform 50,000 pharmacy transactions into sales, product demand, stock, expiry and supplier decision support.

---

## 📌 Project Overview

This project analyses **50,000 pharmacy sales transactions** across **7 branches, 148 medicines and 8 suppliers**, covering January 2022 to June 2023.

**The data was downloaded from published Kaggle source: https://www.kaggle.com/datasets/mrnize/pharmacy-transaction 

The objective was to move beyond descriptive sales reporting and develop a management-focused analytics solution that answers:

- What is driving pharmacy revenue growth?
- Which medicines and categories contribute the most value?
- Which products deserve greater stocking attention?
- Which medicines require closer shelf-life monitoring?
- Are particular medicine categories dependent on specific suppliers?
- How does performance differ across branches?

The project follows an end-to-end analytics workflow:

**Raw Data → Python → MySQL → Power BI → Management Insights**

---

## 🎯 Business Objectives

The analysis was designed around four management areas:

1. **Performance Monitoring**  
   Track revenue, transactions, units sold and average transaction value over time.

2. **Growth Analysis**  
   Determine whether revenue growth is driven by higher demand, transaction activity, pricing or product mix.

3. **Product & Demand Analysis**  
   Identify financially important and high-demand medicines and categories.

4. **Stock, Expiry & Supplier Decision Support**  
   Combine historical demand, revenue contribution, shelf-life patterns and supplier coverage to support management review.

---

## 🛠️ Tools & Technologies

| Tool | Application |
|---|---|
| **Python / Pandas** | Data validation, cleaning, feature engineering and exploratory analysis |
| **MySQL** | Relational data modelling and SQL business analysis |
| **Power BI** | Interactive dashboard development and visual analytics |
| **DAX** | KPIs, time intelligence and management decision measures |
| **Excel** | Structured data transfer and validation |
| **Jupyter Notebook** | Python analysis and documentation |

---

## 🔄 Analytics Workflow

### 1. Data Preparation — Python

The raw transaction data was assessed before analysis to ensure that business conclusions were based on reliable information.

Key preparation included:

- Checking missing values and duplicate records
- Validating unique transaction IDs
- Reviewing categorical and numerical consistency
- Validating medicine ID and medicine name relationships
- Converting and validating transaction and expiry dates
- Checking discount, quantity and price ranges
- Validating transaction revenue calculations
- Investigating systematic missing medicine-strength values
- Creating analysis-ready features

Engineered features included:

- Year, quarter and month
- Year-Month
- Day of week
- Gross sales
- Discount amount
- Customer age group
- Discount group
- Days to expiry

---

### 2. Data Modelling & Analysis — MySQL

The cleaned data was structured into a star-schema model:

- `FactSales`
- `DimDate`
- `DimMedicine`
- `DimBranch`

SQL was then used to analyse:

- Overall sales KPIs
- Monthly and quarterly performance
- Month-over-month growth
- Comparable-period YoY growth
- Medicine price changes
- Product revenue contribution
- Branch performance

Because the dataset ends in **June 2023**, YoY analysis compares **Jan–Jun 2023 with Jan–Jun 2022** rather than incorrectly comparing six months of 2023 with the full 2022 year.

---

## 📊 Power BI Dashboard

# Results & Business Insights

The dashboard was designed as a four-stage analytical story. Rather than presenting isolated KPIs, each page answers a business question raised by the previous stage:

**Performance → Growth Drivers → Product & Demand → Management Decisions**

---

## 1. Executive Performance Overview

![Executive Overview](images/executive_overview.png)

### Business Question

**Is pharmacy performance genuinely improving, and where is that performance coming from?**

### Revenue Performance

- The pharmacy generated **LKR 260.28M** in revenue across approximately **50,000 transactions** and **150,000 units sold** during the 18-month period.
- Quarterly revenue generally strengthened:
  - **Q1 2022:** LKR 41.81M
  - **Q2 2022:** LKR 42.60M
  - **Q3 2022:** LKR 42.47M
  - **Q4 2022:** LKR 43.53M
  - **Q1 2023:** LKR 44.60M
  - **Q2 2023:** LKR 45.26M
- Apart from a small **0.31% decline in Q3 2022**, quarterly revenue maintained a generally positive trajectory.

### Comparable-Period Growth

Because 2023 data ends in June, performance was compared using **Jan–Jun 2023 vs Jan–Jun 2022** rather than comparing a partial year with a full year.

| KPI | YoY Change |
|---|---:|
| Revenue | **+6.46%** |
| Average Transaction Value | **+7.12%** |
| Transactions | **-0.62%** |
| Units Sold | **-0.85%** |

This reveals an important difference between **financial growth and demand growth**.

- Revenue increased by **6.46%**.
- However, the pharmacy processed slightly fewer transactions.
- It also sold slightly fewer units.
- The improvement was therefore not caused by more customer purchases or greater product volume.
- Instead, **Average Transaction Value increased by 7.12%**, more than offsetting the decline in activity.

> **Key Insight:** The pharmacy is generating more revenue from broadly stable/slightly lower sales activity. Revenue growth alone therefore overstates the improvement in underlying demand.

### Branch Performance

- Revenue contribution was highly balanced across all seven branches.
- **Colombo Fort** generated the highest revenue at approximately **LKR 38.04M (14.62%)**.
- **Kandy City** generated the lowest at approximately **LKR 36.03M (13.84%)**.
- The gap between the highest and lowest branch was only around **0.78 percentage points of total revenue share**.
- All branches also carried the full medicine range represented in the dataset.

This suggests that there is **no obvious branch-level performance problem** requiring immediate intervention.

> **Management Implication:** Management should avoid focusing excessively on branch rankings. The more important question is what is happening underneath total revenue — particularly pricing, categories and product-level performance.

### Analytical Transition

The first dashboard establishes a clear issue:

**Revenue increased, but units and transactions did not.**

The next stage therefore investigates:

> **What actually drove the 6.46% increase in revenue?**

---

## 2. Sales & Growth Drivers

![Sales & Growth Drivers](images/sales_growth_drivers.png)

### Business Question

**Was revenue growth driven by stronger demand, higher prices, product mix or customer behaviour?**

### Price vs Volume

The strongest evidence comes from comparing price, units and transaction activity.

- Jan–Jun revenue increased **6.46%**.
- Units sold decreased **0.85%**.
- Transactions decreased **0.62%**.
- Average Transaction Value increased **7.12%**.
- Revenue per unit increased from approximately **LKR 1,684 to LKR 1,809**.
- Average transaction value increased from approximately **LKR 5,065 to LKR 5,426**.

This suggests that the pharmacy earned more from each unit and each transaction rather than processing more demand.

### Medicine Price Movement

Medicine-level analysis provides further evidence:

- **All 148 medicines** recorded higher average prices in Jan–Jun 2023 than in Jan–Jun 2022.
- Median medicine-level price growth was approximately **6.09%**.
- The average medicine-level increase was approximately **5.99%**.
- Individual medicine increases ranged from approximately **1.85% to 9.07%**.

The fact that all 148 medicines increased is particularly important.

The revenue improvement was therefore not dependent on a small number of unusually expensive medicines. Higher pricing was **broadly distributed across the medicine portfolio**.

> **Key Insight:** The combination of higher prices, higher ATV, lower units and lower transactions provides strong evidence that recent revenue growth was primarily **value/price-driven rather than volume-driven**.

### Category Growth

Overall growth also hides significant differences between product categories.

- Some medicine categories achieved substantially stronger YoY revenue growth.
- Others experienced limited growth or decline.
- This means the pharmacy-wide **+6.46%** should not be treated as a uniform performance rate across the portfolio.
- Strong overall results can therefore mask weaker product areas.

> **Management Implication:** Category growth should be monitored separately from total pharmacy growth so management can distinguish expanding categories from those losing momentum.

### Discount Effectiveness

Discount levels were analysed to determine whether higher discounts were associated with larger customer baskets.

Revenue distribution differed across discount groups:

- **Low Discount (1–5%):** ~34.81% of revenue
- **Medium Discount (6–10%):** ~32.86%
- **High Discount (>10%):** ~28.64%
- **No Discount:** ~3.68%

However, average quantity per transaction remained remarkably stable:

- approximately **3 units per transaction** across all discount groups.

This is important because higher discounts did **not** correspond with noticeably larger historical baskets.

> **Management Implication:** Management should not assume that deeper discounts automatically generate greater purchase volume. Margin data would be required to determine whether higher discounts create sufficient financial benefit.

### Customer and Transaction Growth Patterns

The dashboard also compares revenue growth across:

- customer age groups
- payment methods
- prescription requirements

These views help identify where growth is occurring rather than treating all customers and transactions as one population.

However, these relationships are interpreted as **performance patterns rather than causal effects**. For example, stronger growth within one payment method does not prove that the payment method itself caused additional spending.

### Analytical Transition

The growth-driver analysis establishes that:

**Revenue increased largely through higher value rather than higher volume, while growth varied across the product portfolio.**

This raises a more operational question:

> **If medicines have different financial contributions but relatively stable overall demand, which products actually deserve greater management attention?**

---

## 3. Product & Demand Analysis

![Product & Demand Insights](images/product_demand_insights.png)

### Business Question

**Which medicines and categories matter most when both demand and financial contribution are considered?**

### Medicine Demand

Average monthly demand was calculated to compare medicines on a consistent basis.

Across the 148 medicines:

- Average: approximately **56.3 units/month**
- Minimum: approximately **47.7 units/month**
- Maximum: approximately **64.1 units/month**
- Median: approximately **56.5 units/month**

The range is relatively narrow.

This means a simple classification of medicines into dramatic "fast-moving" and "slow-moving" groups would exaggerate differences that are actually quite small.

> **Key Insight:** Medicine demand is relatively balanced. Unit movement alone does not provide enough differentiation for meaningful stock prioritisation.

### Demand vs Revenue

The dashboard therefore considers medicine demand together with revenue.

This reveals an important distinction:

**Products can have similar demand but very different financial importance.**

A medicine may:

- sell frequently and generate high revenue;
- sell frequently but have relatively low financial contribution;
- generate high revenue despite moderate unit demand because of its value;
- contribute relatively little on both measures.

This makes the **Demand vs Revenue** relationship more useful than ranking medicines solely by units sold.

### Revenue Contribution

Contribution analysis provides stronger differentiation:

- **85 medicines** generated approximately **79.67% of total revenue**.
- **35 medicines** generated the next **15.19%**.
- The remaining **28 medicines** generated only approximately **5.14%**.

In proportional terms:

- roughly **57% of medicines generated 80% of revenue**;
- approximately **19% of medicines generated only 5% of revenue**.

The portfolio is therefore not extremely concentrated, but financial contribution is clearly more differentiated than physical demand.

> **Management Implication:** High unit sales should not automatically determine stocking priority. Management should consider whether the medicine is also financially important.

### Category Demand

Category-level demand provides a broader view of where product movement is concentrated.

This helps management distinguish between:

- categories generating high unit demand;
- categories generating high revenue;
- categories where revenue is influenced more strongly by product value than volume.

This is especially useful because medicine-level demand itself is relatively compressed.

### Branch × Category Performance

Overall branch revenue initially appeared very similar.

However, the branch-category heatmap examines the composition beneath those totals.

This allows management to identify:

- categories performing more strongly at particular branches;
- locations with comparatively weaker category demand;
- differences that are hidden when branches are compared using total revenue alone.

> **Key Insight:** Two branches can generate similar total revenue while having different underlying product mixes.

### Analytical Transition

The product analysis establishes that effective stock decisions require more than sales volume.

The decision now becomes:

**Which medicines should be prioritised, maintained or reviewed — and what additional operational risks should be considered?**

---

## 4. Stock, Expiry & Supplier Decision Support

![Management & Supplier Insights](images/management_supplier_insights.png)

### Business Question

**How can historical sales information be translated into practical stock, expiry and sourcing decisions?**

### Stock Prioritisation

Medicine demand and revenue contribution were combined into a management-oriented stock classification.

| Stock Guidance | Analytical Meaning | Management Interpretation |
|---|---|---|
| **Keep More** | Higher relative demand + higher financial importance | Prioritise availability |
| **Maintain** | Mixed/moderate performance | Maintain and monitor |
| **Keep Less / Review** | Lower relative demand + lower financial importance | Review stocking level |

This is more useful than simply creating a "Top 10 Medicines" list because it considers **two dimensions of product importance simultaneously**.

### Historical Shelf-Life Exposure

Stock priority alone is insufficient for pharmacy management.

Holding greater quantities can create additional exposure when products have shorter remaining shelf life.

The analysis therefore measures the proportion of historical units sold with **≤1 year of remaining shelf life**.

Medicines are classified relative to the overall portfolio:

- **High Expiry Attention** — top 25% for historical short shelf-life exposure
- **Medium Expiry Attention** — middle 50%
- **Low Expiry Attention** — bottom 25%

Using portfolio-relative thresholds avoids applying arbitrary fixed cut-offs when the distribution of medicines is relatively similar.

### Combining Stock and Expiry Decisions

The strongest decision support comes from combining both dimensions.

| Stock Position | Expiry Position | Management Priority |
|---|---|---|
| Keep More | High | **Prioritise availability + monitor expiry closely** |
| Keep More | Low/Medium | **Prioritise availability** |
| Maintain | High | **Maintain + strengthen expiry monitoring** |
| Keep Less / Review | High | **Priority stock review** |
| Keep Less / Review | Low/Medium | **Review stocking level** |

This prevents a simplistic recommendation such as:

**"High demand = order more."**

A high-demand medicine may deserve greater availability, but increasing holdings without considering shelf life could increase expiry exposure.

### Supplier Dependency

Supplier analysis adds a sourcing dimension to the decision.

- The dataset contains **8 suppliers**.
- The top three suppliers account for approximately **42.27% of total revenue**.
- Revenue is therefore relatively distributed rather than dominated by a single supplier.

However, overall supplier revenue does not tell the full story.

The **Supplier–Category Coverage** analysis examines how medicines within each category are distributed among suppliers.

This helps identify situations where:

- overall supplier dependency appears low;
- but an individual medicine category may rely on relatively few suppliers.

> **Management Implication:** Supplier risk should be assessed at the category/product level rather than using supplier revenue alone.

### Medicine Stock & Expiry Decision Guide

The final management table consolidates the analysis into a medicine-level decision tool containing:

- Medicine
- Medicine Category
- Stock Guidance
- Management Action
- Average Monthly Units
- Units Sold
- Revenue
- Short Shelf-Life %
- Expiry Attention
- Supplier

Managers can filter the table by expiry-attention level to focus directly on products requiring greater review.

> **Key Insight:** The final decision is not simply "what sells most?" It combines **how consistently a medicine moves, how financially important it is, its historical shelf-life exposure and its supplier context**.

---

# Management Recommendations

## 1. Protect High-Value Demand

- Prioritise availability for medicines classified as **Keep More**.
- Give greatest attention to medicines combining high relative demand with high revenue contribution.
- Avoid using units sold as the sole basis for replenishment decisions.

## 2. Establish a Structured Review of Lower-Priority Medicines

- Review **Keep Less / Review** medicines before maintaining existing stocking patterns.
- Prioritise products that combine lower demand, lower revenue contribution and **High Expiry Attention**.
- Determine whether lower-performing medicines remain operationally necessary despite weaker financial performance.

## 3. Integrate Shelf Life Into Stock Planning

- Treat expiry exposure as a separate consideration from demand.
- Closely monitor **Keep More + High Expiry Attention** medicines when increasing availability.
- Use historical short shelf-life patterns to identify products requiring greater monitoring attention.

## 4. Monitor the Quality of Revenue Growth

- Continue monitoring **Revenue + Transactions + Units + ATV** together.
- Avoid treating revenue growth alone as evidence of stronger customer demand.
- Investigate whether transaction and unit volumes continue declining if revenue remains positive.
- Separate future growth into **price, volume and product-mix effects**.

## 5. Review Pricing and Discount Strategy

- Broad medicine price increases have supported recent revenue growth.
- Monitor whether continued price increases begin to affect transaction or unit demand.
- Review higher discount levels because historical data shows little difference in basket quantity.
- Incorporate gross margin data before making future pricing or discount optimisation decisions.

## 6. Apply More Localised Product Planning

- Overall branch performance does not currently justify major branch-level intervention.
- Focus instead on **branch × category differences**.
- Use local product patterns to inform medicine allocation where meaningful differences emerge.

## 7. Monitor Category-Level Supplier Dependency

- Overall supplier dependency appears relatively diversified.
- Focus sourcing reviews on categories with more concentrated supplier coverage.
- Future supplier assessment should incorporate lead time, fulfilment reliability and purchasing cost rather than treating sales contribution as supplier performance.

---

# Overall Business Conclusion

The analysis reveals a more nuanced performance story than the headline revenue increase suggests:

**Revenue increased 6.46%**
→ but **units and transactions declined slightly**

**Average Transaction Value increased 7.12%**
→ while **all 148 medicines recorded higher average prices**

**Demand remained relatively balanced**
→ but **revenue contribution differed more substantially between medicines**

Therefore:

**Revenue growth should not automatically be interpreted as stronger demand, and stock priority should not automatically be determined by unit sales.**

The analysis consequently progresses from financial performance to growth drivers, then product importance, and finally operational decision support.

The resulting framework combines:

**Demand + Revenue Contribution + Shelf-Life Exposure + Supplier Context**

to provide a more structured basis for medicine-level stock review.

