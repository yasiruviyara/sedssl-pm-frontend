# 📚 Database Schema

This schema defines the **members directory** and **projects workflow** for the organization.

---

## 🧾 Members Table

### 🔗 Relationships

* `user_id` references the `auth.users` table and is unique per member.

### 🎯 Fields

| Column             | Type                  | Description                                                                                       |
| ------------------ | --------------------- | ------------------------------------------------------------------------------------------------- |
| id                 | BIGSERIAL             | Primary key                                                                                       |
| user\_id           | UUID                  | FK → `auth.users(id)`, unique                                                                     |
| initials           | TEXT                  | Member initials                                                                                   |
| full\_name         | TEXT                  | Full name of the member                                                                           |
| phone              | TEXT                  | Phone number                                                                                      |
| gender             | `gender_enum`         | `'male'`, `'female'`, `'other'`                                                                   |
| dob                | DATE                  | Date of birth                                                                                     |
| cv                 | TEXT                  | Link to CV                                                                                        |
| avatar             | TEXT                  | Profile picture URL                                                                               |
| avatar\_visibility | TEXT                  | `'public'` or `'private'` (default `'public'`)                                                    |
| account\_status    | `account_status_enum` | `'pending'`, `'under_review'`, `'approved'`, `'rejected'` (default `'pending'`)                   |
| submitted\_at      | TIMESTAMPTZ           | Auto-filled submission timestamp                                                                  |
| reviewed\_at       | TIMESTAMPTZ           | When application was reviewed                                                                     |
| chapter            | TEXT                  | Chapter the member belongs to                                                                     |
| division           | TEXT                  | Division the member belongs to                                                                    |
| role               | `role_enum`           | `'member'`, `'chapter-lead'`, `'division-head'`, `'board-member'`, `'admin'` (default `'member'`) |
| position           | TEXT                  | Specific position (e.g. secretary, project manager)                                               |

---

## 📂 Projects Table

### 🔗 Relationships

* `proposer_submitter` references `members(id)`.

### 🎯 Fields

| Column              | Type                   | Description                                                                                             |
| ------------------- | ---------------------- | ------------------------------------------------------------------------------------------------------- |
| id                  | BIGSERIAL              | Primary key                                                                                             |
| title               | TEXT                   | Project title                                                                                           |
| description         | TEXT                   | Project description                                                                                     |
| timeline\_start     | DATE                   | Start date                                                                                              |
| timeline\_end       | DATE                   | End date                                                                                                |
| timeline\_duration  | INTERVAL (generated)   | Auto-calculated from start/end                                                                          |
| budget              | NUMERIC(15,2)          | Proposed budget                                                                                         |
| proposer\_type      | `proposer_type_enum`   | `'chapter'` or `'division'`                                                                             |
| proposer            | TEXT                   | Name of proposer (chapter/division)                                                                     |
| proposer\_submitter | BIGINT                 | FK → `members(id)`                                                                                      |
| proposal\_status    | `proposal_status_enum` | Workflow status (`draft`, `submitted`, `under_review`, `returned`, `approved`, `rejected`)              |
| project\_status     | `project_status_enum`  | Execution status (`pending`, `to_do`, `in_progress`, `finalizing`, `completed`, `stopped`, `cancelled`) |
| reject\_reasons     | TEXT\[]                | Reasons for rejection (if any)                                                                          |
| return\_details     | TEXT\[]                | Feedback for returned proposals                                                                         |
| objectives          | TEXT\[]                | List of project objectives                                                                              |
| document\_links     | TEXT\[]                | Supporting documents/links                                                                              |
| created\_at         | TIMESTAMPTZ            | Auto-filled creation timestamp                                                                          |
| updated\_at         | TIMESTAMPTZ            | Auto-filled update timestamp                                                                            |

---

## 👥 Project Members Table

| Column      | Type      | Description                                                   |
| ----------- | --------- | ------------------------------------------------------------- |
| id          | BIGSERIAL | Primary key                                                   |
| project\_id | BIGINT    | FK → `projects(id)` (cascade on delete)                       |
| member\_id  | BIGINT    | FK → `members(id)`                                            |
| role        | TEXT      | Role within project                                           |
| is\_active  | BOOLEAN   | Whether the member is actively participating (default `true`) |

---

## 💬 Project Comments Table

| Column        | Type        | Description                             |
| ------------- | ----------- | --------------------------------------- |
| id            | BIGSERIAL   | Primary key                             |
| project\_id   | BIGINT      | FK → `projects(id)` (cascade on delete) |
| commenter\_id | BIGINT      | FK → `members(id)`                      |
| comment       | TEXT        | Comment text                            |
| created\_at   | TIMESTAMPTZ | Timestamp                               |

---

## ⭐ Project Feedbacks Table

| Column      | Type        | Description                             |
| ----------- | ----------- | --------------------------------------- |
| id          | BIGSERIAL   | Primary key                             |
| project\_id | BIGINT      | FK → `projects(id)` (cascade on delete) |
| feedback    | TEXT        | Feedback text                           |
| created\_at | TIMESTAMPTZ | Timestamp                               |
