<h1 align="center">AirBnB Database - Data Insertion</h1>

This repository contains the SQL data insertion scripts for a sample AirBnB-style property rental database system. It is designed to simulate realistic data for users, properties, bookings, payments, reviews, and messages within the platform.

## Description:
The SQL script inserts sample data into the following tables:
- `User`: Contains user account information (host, guest, admin).
- `Property`: Contains property listings by hosts.
- `Booking`: Records of property bookings made by users.
- `Payment`:User infromation for each booking.
- `Review`: User reviews for booked properties.
- `Message`: Messages between users on the platform.

The data structure uses UUIDs as primary keys for better global uniqueness and scalability.

## Usage:
To use this data insertion script for the AirBnB database:
1. Ensure MySQL is installed and that you have created a database.
2. Set up the database schema by cloning and executing the schema script: [AirBnB Database Schema](https://github.com/lexStack3/alx-airbnb-database/blob/main/database-script-0x01/schema.sql).
3. Clone this repository:
    ```bash
    $ git clone https://github.com/lexStack3/alx-airbnb-database.git
    ```

4. Run the data insertion script:
   ```bash
   $ cat alx-airbnb-database/database-script-0x02/seed.sql | mysql -u your_username -p your_database_name
   ```
   ### Note:
   - Replace `your_username` with your actual MySQL username.
   - You'll be prompted to enter your MySQL password.
   - Replace `your_database_name` with the name of the database you created (e.g., `airbnb_database`)


## Example Queries (to verify insertion)
Here are few SQL queries to help confirm that data was successfully inserted:

### View All Users
```sql
SELECT * FROM User;
```

| user_id | first_name | last_name | email | password_hash | phone_number | role  | created_at |
|--------------------------------------|------------|-----------|--------------------------|---------------|--------------|-------|----------|
| 180b0c5b-738a-4bb1-ac21-66fcc0dec91c | Umaru      | Usman     | doubleu@icloud.com       | UsmaN???      | 07012345678  | guest | 2025-05-21 06:40:50 |
| 1d0e6ad2-32ed-447d-9308-7cecf5c1af4e | Eteka      | Effiong   | etekaffiong@gmail.com    | EtekA???      | 09037367753  | guest | 2025-05-21 06:40:50 |
| 33d731c1-00be-4041-8c5c-1b246d55a3db | Marvellous | Ocha      | captainmarvel@gmail.com  | MarvE???      | 08033764532  | admin | 2025-05-21 06:40:50 |
| 365f30a1-85e4-4f4d-9284-62753e855f39 | Alexander  | Edim      | alexanderedim8@gmail.com | AleX???       | 09033882001  | host  | 2025-05-21 06:40:50 |
| bfb454f9-1b83-4f39-894f-06f571ffcb89 | Victor     | Matthew   | victormatt@icloud.com    | VictoR???     | 08088774992  | host  | 2025-05-21 06:40:50 |


### 2. List All Properties and Their Hosts
```sql
SELECT p.name AS property_name, u.first_name AS host_first_name, u.last_name AS host_last_name
FROM Property p
JOIN User u ON p.host_id = u.user_id;
```

| property_name       | host_first_name | host_last_name |
|---------------------|-----------------|----------------|
| Satellite Estate    | Victor          | Matthew        |
| Imperial Estate     | Victor          | Matthew        |
| Golden Gates Lounge | Alexander       | Edim           |
| Gojac Estate        | Alexander       | Edim           |

### 3. Check Bookings and Guest Details
```sql
SELECT b.booking_id, p.name AS property, u.first_name AS guest, b.start_date, b.end_date
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id;
```
| booking_id | property | guest | start_date | end_date   |
|--------------------------------------|---------------------|-------|------------|------------|
| 201b1b0c-deaa-4570-b1c7-55b6a7c91f09 | Golden Gates Lounge | Eteka | 2025-02-03 | 2025-02-07 |
| 247249a0-cd3b-4976-b254-aad65af2e4ea | Gojac Estate        | Eteka | 2025-03-16 | 2025-03-24 |
| b775e8f9-0b41-4b0a-a7ae-1c8f18980d89 | Imperial Estate     | Umaru | 2025-02-08 | 2025-02-13 |
| f2400697-39e6-4e05-b535-44a81cccf9a2 | Satellite Estate    | Umaru | 2025-01-01 | 2025-02-01 |

### 4. Get All Reviews for a Specific Property
```sql
SELECT r.rating, r.comment, u.first_name AS reviewer
FROM Review r
JOIN User u ON r.user_id = u.user_id
WHERE r.property_id = '994fb47d-34a7-4374-9a1a-ae0af54feea3';
```

| rating | comment| reviewer |
|--------|--------|----------|
|      4 | I had a great time! I couldn-t stop laughing when I accidentally took the wrong keys from the keybox-luckily, everything worked out, and it just added to the fun of my stay. | Eteka    |

### 5. Messages Between Users
```sql
SELECT u1.first_name AS sender, u2.first_name AS recipient, m.message_body
FROM Message m
JOIN User u1 ON m.sender_id = u1.user_id
JOIN User u2 ON m.recipient_id = u2.user_id;
```

| sender    | recipient | message_body|
|-----------|-----------|-------------|
| Victor    | Umaru     | Hello and welcome! We're excited to have you join us. Get ready to laugh, relax, and make some great memories during your stay! |
| Alexander | Eteka     | Welcome to our space! We're thrilled to have you here and hope you'll enjoy the fun, relaxed vibe-we promise you'll leave smiling!. |


## Technologies Used
- MySQL
- UUIDs for primary keys
- SQL DDL and DML scripting

## Notes
- All data values are formatted as `YYYY-MM-DD`.
- Make sure foreign key constraints are in place to maintain relational integrity.
- Sample passwords in the `User` table are placeholders (`Alex???`, etc.) and should not be used in production.

## Contributing
if you'd like to contribute or suggest improvements to this repo, feel free to fork it and open a pull request.

## License
This project is open-source and available under the MIT License.
