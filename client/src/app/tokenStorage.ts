export const loadToken = () => {
  try {
    const token = localStorage.getItem('token');
    if (!token) {
      return undefined;
    }
    return JSON.parse(token);
  } catch (err) {
    return undefined;
  }
};

export const tokenize = (token: string) => JSON.stringify({ auth: { token: token } });

export const saveToken = (token: string | null): void => {
  try {
    if (token) {
      localStorage.setItem('token', tokenize(token));
    }
  } catch (err) {
    // Ignore write errors
  }
};
