# UniTrade - Database Design Report

---

## 1. Identification of Entities and Attributes

The UniTrade system requires persistent storage for several distinct real-world concepts. Each concept is represented as a database entity (table), and the attributes within each entity correspond directly to the data the system must capture to fulfil its functional requirements.

### 1.1 Users

The `users` entity is the central actor of the system. Every operation -- posting an item, placing an order, responding to a help request -- is performed by a registered user. The entity stores authentication credentials, role information, approval workflow state, and academic profile details.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| user_id | INT | Primary Key, Auto Increment | Uniquely identifies each user account |
| full_name | VARCHAR(100) | Not Null | Stores the student's display name |
| email | VARCHAR(100) | Not Null, Unique | Serves as the login identifier; uniqueness prevents duplicate accounts |
| phone | VARCHAR(20) | Not Null, Unique | Contact number; also enforced as unique to prevent duplicate registrations |
| password_hash | VARCHAR(255) | Not Null | Stores a BCrypt-hashed password; the system never retains plaintext passwords |
| role | ENUM('ADMIN','USER') | Not Null, Default 'USER' | Determines the user's access level within the application |
| approval_status | ENUM('PENDING','APPROVED','REJECTED') | Not Null, Default 'PENDING' | Controls whether an administrator has verified the account |
| account_status | ENUM('ACTIVE','INACTIVE','BLOCKED') | Not Null, Default 'ACTIVE' | Allows administrators to suspend or block accounts |
| college_name | VARCHAR(150) | Not Null | Records the student's affiliated institution |
| course_name | VARCHAR(100) | Not Null | Records the student's programme of study |
| academic_year | VARCHAR(20) | Not Null | Records the student's current year of study |
| profile_image | VARCHAR(255) | Nullable | Optional file path to an uploaded profile photograph |
| created_at | TIMESTAMP | Default Current Timestamp | Records the date and time of account creation |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the date and time of the most recent profile change |

The inclusion of `approval_status` is particularly significant. Unlike open-registration platforms, UniTrade requires an administrator to verify each student before they may participate in the marketplace. This design decision reflects the platform's focus on trust and safety within a campus community.

### 1.2 Categories

The `categories` entity provides a classification system for all listings on the platform. It is shared across three distinct content types -- items, services, and help requests -- distinguished by the `category_type` column.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| category_id | INT | Primary Key, Auto Increment | Uniquely identifies each category |
| category_name | VARCHAR(100) | Not Null | Human-readable label displayed to users |
| category_type | ENUM('ITEM','SERVICE','REQUEST') | Not Null, Default 'ITEM' | Specifies which content type this category applies to |
| description | VARCHAR(255) | Nullable | Optional text explaining what the category covers |
| status | ENUM('ACTIVE','INACTIVE') | Not Null, Default 'ACTIVE' | Allows administrators to hide categories without deleting them |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the category was created |

A composite unique constraint on `(category_name, category_type)` permits the same name to exist across different types. For example, a "General" category may exist independently for items, services, and requests without conflict.

### 1.3 Items

The `items` entity represents second-hand goods listed for sale by students. It is the primary marketplace entity.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| item_id | INT | Primary Key, Auto Increment | Uniquely identifies each listing |
| user_id | INT | Foreign Key -> users, Not Null | Identifies the seller who created the listing |
| category_id | INT | Foreign Key -> categories, Not Null | Classifies the item for filtering and browsing |
| title | VARCHAR(150) | Not Null | Short descriptive title for the listing |
| description | TEXT | Not Null | Detailed description of the item |
| price | DECIMAL(10,2) | Not Null, Default 0.00 | Asking price in Nepalese Rupees |
| item_condition | ENUM('NEW','LIKE_NEW','GOOD','USED') | Not Null, Default 'USED' | Describes the physical condition of the item |
| image_path | VARCHAR(255) | Nullable | File path to an uploaded product photograph |
| listing_status | ENUM('PENDING','APPROVED','REJECTED','SOLD','INACTIVE') | Not Null, Default 'PENDING' | Tracks the item through the moderation and sales lifecycle |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the item was listed |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the most recent edit |

The `listing_status` attribute implements a moderation workflow: newly posted items begin as PENDING, an administrator reviews and sets them to APPROVED or REJECTED, and the seller may mark them SOLD once a transaction is completed.

### 1.4 Item Orders

The `item_orders` entity records purchase requests made by buyers for specific items.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| order_id | INT | Primary Key, Auto Increment | Uniquely identifies each order |
| item_id | INT | Foreign Key -> items, Not Null | Identifies which item is being ordered |
| buyer_id | INT | Foreign Key -> users, Not Null | Identifies the student placing the order |
| seller_id | INT | Foreign Key -> users, Not Null | Identifies the student who listed the item |
| quantity | INT | Not Null, Default 1 | Number of units requested |
| message | VARCHAR(255) | Nullable | Optional note from the buyer to the seller |
| order_status | ENUM('PENDING','ACCEPTED','REJECTED','COMPLETED','CANCELLED') | Not Null, Default 'PENDING' | Tracks the order through its lifecycle |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the order was placed |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the most recent status change |

The `seller_id` column is technically derivable from `items.user_id` through a join. However, it is stored directly in this table as a deliberate design decision to improve query performance when loading a seller's order dashboard, avoiding a multi-table join on every page request.

### 1.5 Wishlists

The `wishlists` entity implements a many-to-many relationship between users and items, allowing students to save items they are interested in for later review.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| wishlist_id | INT | Primary Key, Auto Increment | Uniquely identifies each wishlist entry |
| user_id | INT | Foreign Key -> users, Not Null | Identifies the student who saved the item |
| item_id | INT | Foreign Key -> items, Not Null | Identifies the saved item |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the item was added to the wishlist |

A composite unique constraint on `(user_id, item_id)` ensures that a user cannot add the same item to their wishlist more than once.

### 1.6 Remember Tokens

The `remember_tokens` entity supports persistent login sessions. When a user selects "Remember Me" during login, a token is generated and stored in this table alongside a corresponding browser cookie.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| token_id | INT | Primary Key, Auto Increment | Uniquely identifies each token |
| user_id | INT | Foreign Key -> users, Not Null | Identifies which user the token belongs to |
| selector | VARCHAR(32) | Not Null, Unique | Public component used to look up the token record |
| validator_hash | VARCHAR(255) | Not Null | Hashed private component; compared during automatic login |
| expires_at | DATETIME | Not Null | Expiry timestamp after which the token is invalid |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the token was issued |

The split-token design (selector and validator stored separately) follows established security best practice. The selector identifies the database record without exposing the secret, and the validator is stored only as a hash, so even if the database is compromised, the tokens cannot be exploited.

### 1.7 Services

The `services` entity represents peer services offered by students, such as tutoring, graphic design, or programming assistance. This extends the marketplace beyond physical goods.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| service_id | INT | Primary Key, Auto Increment | Uniquely identifies each service listing |
| user_id | INT | Foreign Key -> users, Not Null | Identifies the student offering the service |
| category_id | INT | Foreign Key -> categories, Not Null | Classifies the service |
| title | VARCHAR(150) | Not Null | Short descriptive title |
| description | TEXT | Not Null | Detailed explanation of what the service includes |
| price | DECIMAL(10,2) | Not Null, Default 0.00 | Advertised rate in Nepalese Rupees |
| availability_status | ENUM('AVAILABLE','UNAVAILABLE') | Not Null, Default 'AVAILABLE' | Indicates whether the student is currently accepting requests |
| approval_status | ENUM('PENDING','APPROVED','REJECTED') | Not Null, Default 'PENDING' | Administrator moderation before public visibility |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the service was listed |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the most recent edit |

### 1.8 Service Orders

The `service_orders` entity captures requests from students who wish to hire another student's service.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| service_order_id | INT | Primary Key, Auto Increment | Uniquely identifies each service order |
| service_id | INT | Foreign Key -> services, Not Null | Identifies which service is being requested |
| buyer_id | INT | Foreign Key -> users, Not Null | Identifies the student requesting the service |
| provider_id | INT | Foreign Key -> users, Not Null | Identifies the student providing the service |
| request_message | VARCHAR(255) | Nullable | Optional context or instructions from the buyer |
| order_status | ENUM('PENDING','ACCEPTED','REJECTED','COMPLETED','CANCELLED') | Not Null, Default 'PENDING' | Tracks the service order lifecycle |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the request was placed |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the most recent status change |

### 1.9 Help Requests

The `help_requests` entity allows students to post specific needs -- for example, seeking a project teammate, requesting help with moving, or asking for academic assistance.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| request_id | INT | Primary Key, Auto Increment | Uniquely identifies each help request |
| user_id | INT | Foreign Key -> users, Not Null | Identifies the student who posted the request |
| category_id | INT | Foreign Key -> categories, Not Null | Classifies the type of help needed |
| title | VARCHAR(150) | Not Null | Brief summary of the need |
| description | TEXT | Not Null | Full details of what help is required |
| budget | DECIMAL(10,2) | Not Null, Default 0.00 | Maximum amount the student is willing to pay |
| urgency_level | ENUM('LOW','MEDIUM','HIGH') | Not Null, Default 'MEDIUM' | Signal to responders about time sensitivity |
| request_status | ENUM('OPEN','CLOSED','FULFILLED') | Not Null, Default 'OPEN' | Whether the request is still seeking responses |
| approval_status | ENUM('PENDING','APPROVED','REJECTED') | Not Null, Default 'PENDING' | Administrator moderation |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the request was posted |
| updated_at | TIMESTAMP | Auto-updates on modification | Records the most recent change |

### 1.10 Request Responses

The `request_responses` entity stores replies from students who wish to offer help in response to a posted help request.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| response_id | INT | Primary Key, Auto Increment | Uniquely identifies each response |
| request_id | INT | Foreign Key -> help_requests, Not Null | Identifies which help request this responds to |
| responder_id | INT | Foreign Key -> users, Not Null | Identifies the student offering help |
| response_message | VARCHAR(255) | Not Null | The responder's offer or message |
| response_status | ENUM('PENDING','ACCEPTED','REJECTED') | Not Null, Default 'PENDING' | The original requester can accept or reject the response |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the response was submitted |

### 1.11 Admin Logs

The `admin_logs` entity provides an audit trail of all administrative actions performed on the platform. This supports accountability and allows review of moderation decisions.

| Attribute | Data Type | Constraints | Purpose |
|-----------|-----------|-------------|---------|
| log_id | INT | Primary Key, Auto Increment | Uniquely identifies each log entry |
| admin_id | INT | Foreign Key -> users, Not Null | Identifies the administrator who performed the action |
| action_type | VARCHAR(50) | Not Null | Categorises the action (e.g., APPROVE, REJECT, DELETE) |
| target_table | VARCHAR(50) | Not Null | Records which table was affected |
| target_id | INT | Not Null | Records the primary key of the affected record |
| action_description | VARCHAR(255) | Not Null | Human-readable summary of what was done |
| created_at | TIMESTAMP | Default Current Timestamp | Records when the action was performed |

---

## 2. Relationships Between Entities

The UniTrade database contains seventeen distinct relationships, each enforced through foreign key constraints at the database level. These relationships ensure referential integrity -- it is not possible for an item to reference a user who does not exist, nor for an order to reference an item that has been removed without the order also being handled appropriately.

### 2.1 Users and Items (One-to-Many)

A single user may list multiple items for sale, but each item belongs to exactly one seller. This is implemented through the `user_id` foreign key in the `items` table referencing the `user_id` primary key in `users`. The relationship uses `ON DELETE CASCADE`, meaning that if a user account is deleted, all of their item listings are automatically removed.

### 2.2 Users and Item Orders (One-to-Many, Two Relationships)

The `item_orders` table contains two separate foreign keys referencing the `users` table. The `buyer_id` column identifies the student who placed the order, and the `seller_id` column identifies the student who listed the item. A single user may appear as a buyer in many orders and simultaneously as a seller in many other orders.

### 2.3 Items and Item Orders (One-to-Many)

A single item may receive multiple purchase requests from different buyers. Each order references exactly one item through the `item_id` foreign key. When an item is deleted, all associated orders are removed via `ON DELETE CASCADE`.

### 2.4 Users and Items via Wishlists (Many-to-Many)

The relationship between users and items with respect to wishlisting is many-to-many: a single user may save multiple items, and a single item may be saved by multiple users. This many-to-many relationship is resolved through the `wishlists` junction table, which holds a `user_id` and an `item_id` foreign key. A composite unique constraint prevents duplicate entries.

### 2.5 Users and Remember Tokens (One-to-Many)

A single user may have multiple active remember tokens, for example when logged in from different devices. Each token is linked to exactly one user through the `user_id` foreign key.

### 2.6 Categories and Content Entities (One-to-Many, Three Relationships)

The `categories` table serves as a shared classification system for three content types. Each item references a category through `items.category_id`, each service through `services.category_id`, and each help request through `help_requests.category_id`. These relationships use `ON DELETE RESTRICT`, preventing an administrator from deleting a category that is currently in use.

### 2.7 Users and Services (One-to-Many)

A single user may offer multiple services. Each service is linked to its provider through the `user_id` foreign key in the `services` table.

### 2.8 Services and Service Orders (One-to-Many)

A single service listing may receive multiple order requests from different students. Each service order references exactly one service through the `service_id` foreign key.

### 2.9 Users and Service Orders (One-to-Many, Two Relationships)

Similar to item orders, `service_orders` contains two user references: `buyer_id` for the student requesting the service and `provider_id` for the student fulfilling it.

### 2.10 Users and Help Requests (One-to-Many)

A single user may post multiple help requests. Each request is linked to its author through the `user_id` foreign key.

### 2.11 Help Requests and Request Responses (One-to-Many)

A single help request may receive multiple responses from different students. Each response references its parent request through the `request_id` foreign key. Deletion of a help request cascades to remove all associated responses.

### 2.12 Users and Request Responses (One-to-Many)

A single user may respond to multiple help requests. Each response identifies its author through the `responder_id` foreign key.

### 2.13 Users and Admin Logs (One-to-Many)

A single administrator may generate many log entries over time. Each log entry is linked to the responsible administrator through the `admin_id` foreign key.

### Summary of Relationships

| Parent Entity | Child Entity | Relationship Type | Foreign Key |
|---------------|-------------|-------------------|-------------|
| users | items | One-to-Many | items.user_id |
| users | item_orders (as buyer) | One-to-Many | item_orders.buyer_id |
| users | item_orders (as seller) | One-to-Many | item_orders.seller_id |
| items | item_orders | One-to-Many | item_orders.item_id |
| users + items | wishlists | Many-to-Many (junction) | wishlists.user_id, wishlists.item_id |
| users | remember_tokens | One-to-Many | remember_tokens.user_id |
| categories | items | One-to-Many | items.category_id |
| categories | services | One-to-Many | services.category_id |
| categories | help_requests | One-to-Many | help_requests.category_id |
| users | services | One-to-Many | services.user_id |
| services | service_orders | One-to-Many | service_orders.service_id |
| users | service_orders (as buyer) | One-to-Many | service_orders.buyer_id |
| users | service_orders (as provider) | One-to-Many | service_orders.provider_id |
| users | help_requests | One-to-Many | help_requests.user_id |
| help_requests | request_responses | One-to-Many | request_responses.request_id |
| users | request_responses | One-to-Many | request_responses.responder_id |
| users | admin_logs | One-to-Many | admin_logs.admin_id |

---

## 3. Entity Relationship Diagram Explanation

The Entity Relationship Diagram for UniTrade represents eleven entities and seventeen relationships. The diagram uses crow's foot notation to indicate cardinality.

The `users` entity occupies the central position, as it participates in more relationships than any other entity. Lines extend from `users` to `items`, `item_orders`, `wishlists`, `remember_tokens`, `services`, `service_orders`, `help_requests`, `request_responses`, and `admin_logs`.

The `categories` entity serves as a shared parent for three content entities: `items`, `services`, and `help_requests`. Each of these relationships is one-to-many -- one category may classify many listings, but each listing belongs to exactly one category.

The `wishlists` table is drawn as a junction entity between `users` and `items`, representing the only many-to-many relationship in the schema. It is connected to both parent entities with crow's foot (many) notation on the `wishlists` side and a single line (one) on the `users` and `items` sides.

Order entities (`item_orders` and `service_orders`) each have two lines connecting to `users` -- one for the buyer role and one for the seller/provider role. This dual-reference pattern is annotated with role labels on the diagram to avoid ambiguity.

The `help_requests` and `request_responses` pair follows a one-to-many parent-child pattern: one request receives many responses.

The `admin_logs` entity connects to `users` through a single one-to-many relationship, representing the administrative audit trail.

### Textual ERD Representation

```
users (PK: user_id)
+-- items                   (FK: user_id)
|   +-- item_orders         (FK: item_id)
|   +-- wishlists           (FK: item_id)
+-- item_orders             (FK: buyer_id, seller_id)
+-- wishlists               (FK: user_id)
+-- remember_tokens         (FK: user_id)
+-- services                (FK: user_id)
|   +-- service_orders      (FK: service_id)
+-- service_orders          (FK: buyer_id, provider_id)
+-- help_requests           (FK: user_id)
|   +-- request_responses   (FK: request_id)
+-- request_responses       (FK: responder_id)
+-- admin_logs              (FK: admin_id)

categories (PK: category_id)
+-- items                   (FK: category_id)
+-- services                (FK: category_id)
+-- help_requests           (FK: category_id)
```

---

## 4. Normalisation

The following section demonstrates the normalisation process applied to the UniTrade database, progressing from an unnormalised state through to Third Normal Form. Each stage uses data drawn from the actual system to illustrate the transformations.

### 4.1 Unnormalised Form (UNF)

Before any normalisation, the data for a student's marketplace activity could be stored in a single flat structure. Consider the following representation:

| user_id | full_name | email | college_name | item_titles | item_prices | item_categories | buyer_names | wishlist_items |
|---------|-----------|-------|--------------|-------------|-------------|-----------------|-------------|----------------|
| 1 | Bipin Joshi | bipin@ku.edu.np | Kathmandu University | Java Textbook, Physics Lab Kit | 350.00, 800.00 | Textbooks, Lab Equipment | Ram Sharma, Sita Thapa | Laptop Stand, Notebook Set |

This structure contains several problems that make it unsuitable for a relational database:

- **Multi-valued attributes**: The `item_titles`, `item_prices`, and `item_categories` columns contain comma-separated lists. It is not possible to query individual items, sort by price, or filter by category.
- **Repeating groups**: Orders and wishlist entries are embedded as lists within a single user row, violating the fundamental principle that each cell should hold one value.
- **Redundancy**: If a user updates their college name, the change must be applied to every row that contains their items, orders, and wishlist entries.

### 4.2 First Normal Form (1NF)

**Rule**: Every column must contain a single atomic value. There must be no repeating groups.

To achieve 1NF, the multi-valued columns are separated so that each row contains data for exactly one item:

| user_id | full_name | email | college_name | item_id | item_title | item_price | category_name | category_description |
|---------|-----------|-------|--------------|---------|------------|------------|---------------|----------------------|
| 1 | Bipin Joshi | bipin@ku.edu.np | Kathmandu University | 101 | Java Textbook | 350.00 | Textbooks | Academic textbooks and study materials |
| 1 | Bipin Joshi | bipin@ku.edu.np | Kathmandu University | 102 | Physics Lab Kit | 800.00 | Lab Equipment | Lab coats, kits, instruments |

Every cell now contains a single value, and each row represents one distinct item listing. However, the user's personal information (`full_name`, `email`, `college_name`) is repeated identically across every item they have posted. This redundancy introduces the risk of update anomalies -- if the user changes their college, every row must be modified consistently.

### 4.3 Second Normal Form (2NF)

**Rule**: The table must be in 1NF, and every non-key attribute must depend on the entire primary key, not just part of it. This rule applies when the primary key is composite.

In the 1NF table, if we consider the composite primary key `(user_id, item_id)`, several partial dependencies exist:

- `full_name`, `email`, and `college_name` depend only on `user_id` -- they do not require `item_id` to be determined.
- `item_title`, `item_price`, and `category_name` depend only on `item_id` -- they do not require `user_id` to be determined.

These are partial dependencies, which violate 2NF.

**Transformation**: The data is decomposed into two separate tables, each with a single-column primary key:

**users**:

| user_id (PK) | full_name | email | college_name | course_name | academic_year |
|---------------|-----------|-------|--------------|-------------|---------------|
| 1 | Bipin Joshi | bipin@ku.edu.np | Kathmandu University | BCA | 2nd Year |

**items**:

| item_id (PK) | user_id (FK) | title | price | item_condition | category_name | category_description |
|---------------|--------------|-------|-------|----------------|---------------|----------------------|
| 101 | 1 | Java Textbook | 350.00 | GOOD | Textbooks | Academic textbooks and study materials |
| 102 | 1 | Physics Lab Kit | 800.00 | USED | Lab Equipment | Lab coats, kits, instruments |

Now, every non-key attribute in `users` depends entirely on `user_id`, and every non-key attribute in `items` depends entirely on `item_id`. Partial dependencies have been eliminated. If a user's college changes, only one row in the `users` table requires modification.

### 4.4 Third Normal Form (3NF)

**Rule**: The table must be in 2NF, and no non-key attribute may depend on another non-key attribute. This eliminates transitive dependencies.

In the 2NF `items` table above, a transitive dependency remains:

- `item_id -> category_name` (the item determines its category)
- `category_name -> category_description` (the category name determines the description)

Therefore, `category_description` depends on `category_name`, which in turn depends on `item_id`. This is a transitive dependency: `item_id -> category_name -> category_description`.

**Transformation**: The category information is extracted into its own table:

**categories**:

| category_id (PK) | category_name | category_type | description | status |
|-------------------|---------------|---------------|-------------|--------|
| 1 | Textbooks | ITEM | Academic textbooks and study materials | ACTIVE |
| 2 | Lab Equipment | ITEM | Lab coats, kits, instruments | ACTIVE |

**items** (revised):

| item_id (PK) | user_id (FK) | category_id (FK) | title | price | item_condition |
|---------------|--------------|-------------------|-------|-------|----------------|
| 101 | 1 | 1 | Java Textbook | 350.00 | GOOD |
| 102 | 1 | 2 | Physics Lab Kit | 800.00 | USED |

Now, every attribute in each table depends directly and solely on that table's primary key. There are no transitive dependencies. If a category's description changes, only one row in the `categories` table is updated, regardless of how many items belong to that category.

The same decomposition principle was applied throughout the entire schema. Orders, wishlists, services, help requests, responses, and logs were each separated into independent tables where every attribute depends only on the entity's own primary key.

### 4.5 Note on Justified Denormalisation

The `seller_id` column in `item_orders` and the `provider_id` column in `service_orders` represent a deliberate departure from strict 3NF. In both cases, the seller or provider identity is derivable by joining through the related item or service table. However, storing this value directly avoids a multi-table join on high-frequency queries such as "show all orders I need to fulfil." This is a recognised practice in production database design, where controlled denormalisation is accepted when it yields a meaningful performance benefit and the redundancy risk is manageable.

---

## 5. Final Normalisation Statement

The UniTrade database schema is fully normalised to Third Normal Form (3NF). Every non-key attribute in every table depends directly and exclusively on the primary key of that table. There are no partial dependencies and no transitive dependencies.

Two instances of controlled denormalisation exist by design: `item_orders.seller_id` and `service_orders.provider_id`. These were introduced intentionally to optimise query performance for seller and provider dashboards, and they are documented as an accepted trade-off between strict normalisation and practical efficiency.

All relationships are enforced through foreign key constraints at the database engine level, ensuring referential integrity. Cascade and restrict rules have been applied according to the business logic of each relationship.

---
