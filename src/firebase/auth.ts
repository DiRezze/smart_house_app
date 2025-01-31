import { createUserWithEmailAndPassword, signInWithEmailAndPassword, signOut } from "firebase/auth";
import { auth } from "./firebaseConfig";

export const docCeateUserWithEmailAndPassword = (email:string, password:string) => {
    return createUserWithEmailAndPassword(auth, email, password)
};

export const doSignInWithEmailAndPassword = (email:string, password:string) => {
    return signInWithEmailAndPassword(auth, email, password);
};

export const doSignOut = () => {
    return signOut(auth);
};