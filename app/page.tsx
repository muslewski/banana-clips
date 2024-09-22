import Link from "next/link";

export default function Home() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen p-8 font-[family-name:var(--font-geist-sans)]">
      <h1 className="text-4xl font-bold mb-6">Welcome to Banana Clips</h1>
      <p className="text-xl mb-8">Get started by exploring our dashboard.</p>
      <Link
        href="/dashboard"
        className="bg-[#fbec5d] hover:bg-[#ffed4b] text-background font-bold py-2 px-4 rounded"
      >
        Go to Dashboard
      </Link>
    </main>
  );
}
