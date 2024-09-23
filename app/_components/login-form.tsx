export default function LoginForm() {
  return (
    <form className="w-full max-w-md">
      <div className="mb-4">
        <label htmlFor="email" className="block mb-2">
          Email
        </label>
        <input
          type="email"
          id="email"
          name="email"
          className="w-full p-2 border rounded text-black"
          required
        />
      </div>
      <div className="mb-6">
        <label htmlFor="password" className="block mb-2">
          Password
        </label>
        <input
          type="password"
          id="password"
          name="password"
          className="w-full p-2 border rounded text-black"
          required
        />
      </div>
      <button
        type="submit"
        className="w-full bg-[#fbec5d] hover:bg-[#ffed4b] text-background font-bold py-2 px-4 rounded"
      >
        Sign In
      </button>
    </form>
  );
}
