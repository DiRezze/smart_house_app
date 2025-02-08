import React from "react";
import { colors } from "../../constants/colors";
import { auth } from "../../firebase/firebaseConfig";
import PrimaryButton from "../../components/primaryButton";
import { StyleSheet, Text, View } from "react-native";
import { createUserWithEmailAndPassword } from "firebase/auth";
import InputField from "../../components/inputField";
import AuthLayout from "../../layouts/authLayout";
import { Controller, useForm } from "react-hook-form";

const SigninTab = () => {
  const {
    control,
    handleSubmit,
    formState: { errors },
    setError,
  } = useForm({
    defaultValues: {
      email: "",
      password: "",
      repassword: "",
    },
  });

  const handleSignup = async (data: {
    email: string;
    password: string;
    repassword: string;
  }) => {
    const { email, password, repassword } = data;

    if (password !== repassword) {
      setError("repassword", {
        type: "manual",
        message: "As senhas não coincidem.",
      });
      return;
    }

    try {
      await createUserWithEmailAndPassword(auth, email, password);
    } catch (error) {
      console.log("Erro ao criar usuário: ", error);
    }
  };

  return (
    <AuthLayout backButton={true}>
      <View style={styles.modal}>
        <View style={styles.formContainer}>
          <Text style={styles.title}>Cadastrar</Text>

          <Controller
            control={control}
            name="email"
            render={({ field: { onChange, value } }) => (
              <InputField
                placeholder="E-mail"
                iconName="mail"
                secure={false}
                value={value}
                callback={onChange}
                errorMsg={errors.email?.message}
              />
            )}
            rules={{
              required: "E-mail é obrigatório",
              pattern: {
                value: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
                message: "Formato de e-mail inválido",
              },
            }}
          />
          <Controller
            control={control}
            name="password"
            render={({ field: { onChange, value } }) => (
              <InputField
                placeholder="Crie uma senha"
                iconName="key"
                secure={true}
                value={value}
                callback={onChange}
                errorMsg={
                  errors.root?.message
                    ? errors.root?.message
                    : errors.password?.message
                }
              />
            )}
            rules={{
              required: "Senha é obrigatória",
              minLength: {
                value: 6,
                message: "A senha deve ter pelo menos 6 caracteres",
              },
            }}
          />
          <Controller
            control={control}
            name="repassword"
            render={({ field: { onChange, value } }) => (
              <InputField
                placeholder="Repita a senha"
                iconName="key"
                secure={true}
                value={value}
                callback={onChange}
                errorMsg={errors.repassword?.message}
              />
            )}
            rules={{
              required: "Repita a senha",
            }}
          />

          <PrimaryButton
            textContent={"Criar conta"}
            action={handleSubmit(handleSignup)}
          />
        </View>
      </View>
    </AuthLayout>
  );
};

export default SigninTab;

const styles = StyleSheet.create({
  modal: {
    backgroundColor: "#060606",
  },
  forgot: {
    color: colors.dark.softGray,
    fontSize: 16,
  },
  title: {
    fontSize: 48,
    textAlign: "center",
    fontWeight: 600,
    color: colors.dark.primary,
  },
  formContainer: {
    backgroundColor: colors.dark.softBlack,
    width: "auto",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "flex-start",
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    padding: 8,
    gap: 8,
    minHeight: "75%",
  },
});
