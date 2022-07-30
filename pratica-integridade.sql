CREATE TABLE customers (
id SERIAL PRIMARY KEY NOT NULL,
"fullName" VARCHAR(50) NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
password VARCHAR(50) NOT NULL
);

CREATE TABLE "bankAccount" (
id SERIAL PRIMARY KEY NOT NULL,
"customerId" INTEGER NOT NULL REFERENCES customers(id),
"accountNumber" VARCHAR(20) NOT NULL,
agency VARCHAR(8) NOT NULL,
"openDate" DATE NOT NULL DEFAULT NOW(),
"closeDate" DATE DEFAULT NULL
);

CREATE TABLE states (
id SERIAL PRIMARY KEY NOT NULL,
name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE cities (
id SERIAL PRIMARY KEY NOT NULL,
name VARCHAR(30) NOT NULL,
"stateId" INTEGER NOT NULL REFERENCES states(id)
);

CREATE TABLE "customerAddresses" (
id SERIAL NOT NULL PRIMARY KEY,
"customerId" INTEGER NOT NULL REFERENCES customers(id) UNIQUE,
street TEXT NOT NULL,
"number" TEXT NOT NULL,
complement TEXT NOT NULL,
"postalCode" TEXT NOT NULL,
"cityId" INTEGER NOT NULL REFERENCES cities(id)
);

CREATE TYPE phone_type AS ENUM ('landline','mobile');
CREATE TYPE transaction_type AS ENUM ('deposit','withdraw');

CREATE TABLE "customerPhones" (
id SERIAL PRIMARY KEY NOT NULL,
"customerId" INTEGER NOT NULL REFERENCES customers(id),
"number" VARCHAR(15) NOT NULL,
type phone_type NOT NULL
);

CREATE TABLE "transactions" (
id SERIAL PRIMARY KEY NOT NULL,
"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
amount INTEGER NOT NULL,
type transaction_type NOT NULL,
time TIME DEFAULT NOW() NOT NULL,
description TEXT,
cancelled BOOL DEFAULT false
);

CREATE TABLE "creditCards" (
id SERIAL PRIMARY KEY NOT NULL,
"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
name VARCHAR(20) NOT NULL,
"number" INTEGER NOT NULL UNIQUE,
"securityCode" VARCHAR(3) NOT NULL,
"expirationMonth" DATE NOT NULL,
"expirationYear" DATE NOT NULL,
"password" VARCHAR(6) NOT NULL,
"limit" INTEGER NOT NULL DEFAULT 1500
);



