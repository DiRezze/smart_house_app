import React, { createContext, ReactNode, useContext, useState } from "react";
import { auth, onAuthStateChanged, User } from "../firebase/firebaseConfig";
import { doSignInWithEmailAndPassword, doSignOut } from "../firebase/auth";
import Loader from "../components/loader";
import { FirebaseError } from "firebase/app";
import useToast from "../hooks/useToast";
import { handleAuthError } from "../scripts/handleAuthError";

interface AuthContextType {
  isAuthenticated: boolean;
  currentUser: User | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(false);

  const { showToast } = useToast();

  const signIn = async (email: string, password: string): Promise<void> => {
    setLoading(true);
    try {
      const userCredential = await doSignInWithEmailAndPassword(
        email,
        password
      );
      setCurrentUser(userCredential.user);
      setIsAuthenticated(true);
    } catch (error) {
      if (error instanceof FirebaseError) {
        const errorText = handleAuthError(error);
        showToast(`Erro de autenticação: ${errorText}`, "long");
      } else {
        showToast(`Erro desconhecido: ${error}`, "short");
      }
      setIsAuthenticated(false);
      setCurrentUser(null);
    } finally {
      setLoading(false);
    }
  };

  const signOut = async () => {
    setLoading(true);
    try {
      await doSignOut();
      setIsAuthenticated(false);
      setCurrentUser(null);
    } catch (error) {
      console.error("Erro ao deslogar", error);
    } finally {
      setLoading(false);
    }
  };

  React.useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setCurrentUser(user);
      setIsAuthenticated(!!user);
      setLoading(false);
    });

    return () => unsubscribe();
  }, []);

  return (
    <AuthContext.Provider
      value={{ isAuthenticated, currentUser, loading, signIn, signOut }}
    >
      {loading ? <Loader /> : children}
    </AuthContext.Provider>
  );
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
