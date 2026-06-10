import { Sidebar } from "@/components/Sidebar";
import { Navbar } from "@/components/Navbar";

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-canvas">
      <Sidebar />
      <div className="pl-64">
        <Navbar />
        <main className="px-6 py-6 lg:px-8 lg:py-8">{children}</main>
      </div>
    </div>
  );
}
