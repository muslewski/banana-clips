import bcrypt from "bcrypt";
import { db } from "@vercel/postgres";
import { users } from "@/app/_lib/placeholder-data";

const client = await db.connect();

async function seedUsers() {
  await client.sql`CREATE EXTENSION IF NOT EXISTS "uuid-ossp"`;
  await client.sql`
    CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(60) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP WITH TIME ZONE,
    user_role VARCHAR(20) DEFAULT 'user',
    email_verified BOOLEAN DEFAULT FALSE
    )
  `;

  const insertedUsers = await Promise.all(
    users.map(async (user) => {
      const hashedPassword = await bcrypt.hash(user.password, 10);
      return client.sql`
        INSERT INTO users (id, username, email, password_hash, created_at, updated_at, is_active, last_login, user_role, email_verified)
        VALUES (${user.id}, ${user.username}, ${user.email}, ${hashedPassword}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, ${user.is_active}, ${user.last_login}, ${user.user_role}, ${user.email_verified})
        ON CONFLICT (id) DO NOTHING;
      `;
    })
  );

  return insertedUsers;
}

export async function GET() {
  try {
    await client.sql`BEGIN`;
    await seedUsers();
    await client.sql`COMMIT`;

    return Response.json({ message: "Database seeded successfully" });
  } catch (error) {
    await client.sql`ROLLBACK`;
    console.error("Error seeding database:", error);
    return Response.json({ error }, { status: 500 });
  }
}
