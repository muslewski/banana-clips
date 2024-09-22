import Link from "next/link";

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex">
      <nav className="h-screen w-64 flex flex-col gap-12 items-center p-4 bg-slate-900">
        <Link href="/dashboard">Dashboard</Link>
        <Link href="/dashboard/editor">Editor</Link>
      </nav>
      {children}
    </div>
  );
}
