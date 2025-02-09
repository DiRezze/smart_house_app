import { FirebaseError } from "firebase/app";

export const handleAuthError = (error: FirebaseError) => {
  switch (error.code) {
    case "auth/invalid-email":
      return "E-mail inválido!";
    case "auth/invalid-credential":
      return "Crendenciais incorretas!";
    case "auth/user-not-found":
      return "Usuário não encontrado!";
    case "auth/wrong-password":
      return "Senha incorreta!";
    default:
      return "Erro desconhecido!";
  }
};
