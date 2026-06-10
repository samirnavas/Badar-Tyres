"use client";

import { useState } from "react";
import {
  QueryClient,
  QueryClientProvider,
  defaultShouldDehydrateQuery,
} from "@tanstack/react-query";

export function Providers({ children }: { children: React.ReactNode }) {
  const [queryClient] = useState(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: {
            staleTime: 30 * 1000,
            refetchOnWindowFocus: false,
            retry: 1,
          },
          dehydrate: {
            shouldDehydrateQuery: defaultShouldDehydrateQuery,
          },
        },
      }),
  );

  return (
    <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
  );
}
