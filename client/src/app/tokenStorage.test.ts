import { loadToken, saveToken, tokenize } from './tokenStorage';

describe('loadToken', () => {
  it('loads the token from localStorage', () => {
    const spy = jest.spyOn(Storage.prototype, 'getItem');
    loadToken();
    expect(spy).toHaveBeenCalledWith('token');
  });
});

describe('saveToken', () => {
  it('saves the token to localStorage', () => {
    const spy = jest.spyOn(Storage.prototype, 'setItem');
    saveToken('some_token');
    expect(spy).toHaveBeenCalledWith('token', tokenize('some_token'));
  });
});
