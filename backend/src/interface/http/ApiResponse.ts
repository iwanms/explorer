export const successResponse = (data: unknown, message = "OK") => ({
  success: true,
  message,
  data,
});

export const errorResponse = (message: string, code = "INTERNAL_ERROR") => ({
  success: false,
  message,
  error: { code },
});
