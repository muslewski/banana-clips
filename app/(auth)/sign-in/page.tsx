import Link from "next/link";
import LoginForm from "@/app/_components/login-form";
export default function SignIn() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen p-8 font-[family-name:var(--font-geist-sans)]">
      <h1 className="text-4xl font-bold mb-6">Sign In</h1>
      <LoginForm />
      <p className="mt-4">
        Don't have an account?{" "}
        <Link href="/sign-up" className="text-blue-500 hover:underline">
          Sign Up
        </Link>
      </p>
    </div>
  );
}
