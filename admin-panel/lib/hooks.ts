"use client";

import {
  useMutation,
  useQuery,
  useQueryClient,
} from "@tanstack/react-query";
import { api } from "./api";
import type { CreateJobPayload, JobStatus } from "./types";

export const queryKeys = {
  metrics: ["metrics"] as const,
  jobs: (filters?: { status?: JobStatus | "all"; search?: string }) =>
    ["jobs", filters ?? {}] as const,
  technicians: ["technicians"] as const,
  manufacturers: ["manufacturers"] as const,
  vehicles: ["vehicles"] as const,
};

export function useMetrics() {
  return useQuery({
    queryKey: queryKeys.metrics,
    queryFn: api.getMetrics,
  });
}

export function useJobs(filters?: {
  status?: JobStatus | "all";
  search?: string;
}) {
  return useQuery({
    queryKey: queryKeys.jobs(filters),
    queryFn: () => api.getJobs(filters),
  });
}

export function useTechnicians() {
  return useQuery({
    queryKey: queryKeys.technicians,
    queryFn: api.getTechnicians,
  });
}

export function useManufacturers() {
  return useQuery({
    queryKey: queryKeys.manufacturers,
    queryFn: api.getManufacturers,
  });
}

export function useVehicles() {
  return useQuery({
    queryKey: queryKeys.vehicles,
    queryFn: api.getVehicles,
  });
}

export function useCreateJob() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: (payload: CreateJobPayload) => api.createJob(payload),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["jobs"] });
      queryClient.invalidateQueries({ queryKey: queryKeys.metrics });
      queryClient.invalidateQueries({ queryKey: queryKeys.vehicles });
    },
  });
}
