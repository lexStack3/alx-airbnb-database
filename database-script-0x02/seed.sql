INSERT INTO `User` (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    ("365f30a1-85e4-4f4d-9284-62753e855f39",
    "Alexander",
    "Edim",
    "alexanderedim8@gmail.com",
    "AleX???",
    "09033882001",
    "host"),

    ("180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    "Umaru",
    "Usman",
    "doubleu@icloud.com",
    "UsmaN???",
    "07012345678",
    "guest"),

    ("1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    "Eteka",
    "Effiong",
    "etekaffiong@gmail.com",
    "EtekA???",
    "09037367753",
    "guest"),

    ("bfb454f9-1b83-4f39-894f-06f571ffcb89",
    "Victor",
    "Matthew",
    "victormatt@icloud.com",
    "VictoR???",
    "08088774992",
    "host"),

    ("33d731c1-00be-4041-8c5c-1b246d55a3db",
    "Marvellous",
    "Ocha",
    "captainmarvel@gmail.com",
    "MarvE???",
    "08033764532",
    "admin");

INSERT INTO `Property` (property_id, host_id, name, description, location, pricepernight)
VALUES
    ("994fb47d-34a7-4374-9a1a-ae0af54feea3",
    "365f30a1-85e4-4f4d-9284-62753e855f39",
    "Gojac Estate",
    "Self contain with AC, Free Wi-Fi and Constant Electricity.",
    "Calabar Municipality",
    2500.50),

    ("3d6f5480-c1c9-4d59-b255-e12825fbbd86",
    "bfb454f9-1b83-4f39-894f-06f571ffcb89",
    "Imperial Estate",
    "One bedroom flat with free internet.",
    "Ikom",
    7000.00),

    ("1fed5bcf-f32c-48e1-8fe4-423a27bf6d09",
    "bfb454f9-1b83-4f39-894f-06f571ffcb89",
    "Satellite Estate",
    "Two Bedroom Flat with free internet and Steady Electricity.",
    "Uyo",
    9000.00),

    ("802a8cd9-8e44-443e-ba7d-9df0f0573474",
    "365f30a1-85e4-4f4d-9284-62753e855f39",
    "Golden Gates Lounge",
    "Self contain with AC, Free Wi-Fi and Constant Electricity.",
    "Calabar South",
    3000.00);

INSERT INTO `Booking` (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    ("247249a0-cd3b-4976-b254-aad65af2e4ea",
    "994fb47d-34a7-4374-9a1a-ae0af54feea3",
    "1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    '2025-03-16',
    '2025-03-24',
    20000.00,
    "confirmed"),

    ("b775e8f9-0b41-4b0a-a7ae-1c8f18980d89",
    "3d6f5480-c1c9-4d59-b255-e12825fbbd86",
    "180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    '2025-02-08',
    '2025-02-13',
    35000.00,
    "confirmed"),

    ("f2400697-39e6-4e05-b535-44a81cccf9a2",
    "1fed5bcf-f32c-48e1-8fe4-423a27bf6d09",
    "180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    '2025-01-01',
    '2025-02-01',
    217000.00,
    "confirmed"),
    
    ("201b1b0c-deaa-4570-b1c7-55b6a7c91f09",
    "802a8cd9-8e44-443e-ba7d-9df0f0573474",
    "1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    '2025-02-03',
    '2025-02-07',
    12000.00,
    "confirmed");

INSERT INTO `Payment` (payment_id, booking_id, amount, payment_method)
VALUES
    ("e4db101e-35c6-4696-9010-3f4bf91bb926",
    "247249a0-cd3b-4976-b254-aad65af2e4ea",
    20000.00,
    "paypal"),

    ("e6c2abf0-1c4a-4485-ad14-bec94ac082ef",
    "b775e8f9-0b41-4b0a-a7ae-1c8f18980d89",
    35000.00,
    "stripe"),

    ("2cec29b2-a3d0-4564-be4f-543ff70cb87a",
    "f2400697-39e6-4e05-b535-44a81cccf9a2",
    217000.00,
    "paypal"),

    ("9fa85bd5-a028-4a23-b87c-07dcbbfb38ae",
    "201b1b0c-deaa-4570-b1c7-55b6a7c91f09",
    12000.00,
    "credit_card");

INSERT INTO `Review` (review_id, property_id, user_id, rating, comment)
VALUES
    ("43a03982-9dce-4c5e-ba0c-74a24153567c",
    "994fb47d-34a7-4374-9a1a-ae0af54feea3",
    "1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    4,
    "I had a great time! I couldn’t stop laughing when I accidentally took the wrong keys from the keybox—luckily, everything worked out, and it just added to the fun of my stay."),
    
    ("8456eb3a-c8dd-4616-93dc-c8ba58449e50",
    "802a8cd9-8e44-443e-ba7d-9df0f0573474",
    "1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    5,
    "Thanks for hosting! I laughed out loud when I tried to figure out how to use the microwave and ended up pressing every button—your place brought lots of joy and good memories."),

    ("6e9f58bf-7460-405b-bfac-e0846b97f608",
    "1fed5bcf-f32c-48e1-8fe4-423a27bf6d09",
    "180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    3,
    "Thanks for a wonderful experience! I had a good chuckle when I realized I’d been calling the street the wrong name until the last minute—your place truly made my trip memorable, with plenty of laughs along the way."),

    ("a713f166-9eec-474c-9de3-4a20042fe5d1",
    "3d6f5480-c1c9-4d59-b255-e12825fbbd86",
    "180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    5,
    "Honestly, I had a fantastic stay! Your place is cozy and well-kept, and I couldn’t help but laugh when I accidentally kicked a sock under the couch—made me feel right at home, laughing at my own clumsiness!");

INSERT INTO `Message` (message_id, sender_id, recipient_id, message_body)
VALUES
    ("f7f74c7f-509e-491a-b889-1057da4f8cb5",
    "365f30a1-85e4-4f4d-9284-62753e855f39",
    "1d0e6ad2-32ed-447d-9308-7cecf5c1af4e",
    "Welcome to our space! We're thrilled to have you here and hope you'll enjoy the fun, relaxed vibe—we promise you'll leave smiling!."),

    ("09cd514d-444f-4a68-b146-c77eceda61de",
    "bfb454f9-1b83-4f39-894f-06f571ffcb89",
    "180b0c5b-738a-4bb1-ac21-66fcc0dec91c",
    "Hello and welcome! We're excited to have you join us. Get ready to laugh, relax, and make some great memories during your stay!");
