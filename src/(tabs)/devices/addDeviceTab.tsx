import { Text, StyleSheet, TextInput, View } from "react-native";
import TabScroll from "../../components/tabScroll";
import { colors } from "../../constants/colors";
import PrimaryButton from "../../components/primaryButton";
import BackNavigateButton from "../../components/backNavigate";
import { Controller, useForm } from "react-hook-form";
import InputField from "../../components/inputField";
import { push, ref, set } from "firebase/database";
import { auth, db } from "../../firebase/firebaseConfig";
import { useNavigation } from "@react-navigation/native";

const AddDeviceTab = () => {
  const navigation = useNavigation();
  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm({
    defaultValues: {
      deviceName: "",
      mqttTopic: "",
    },
  });

  const handleDeviceCreation = async (data: any) => {
    try {
      const authInstance = auth;
      const user = authInstance.currentUser;
      if (user) {
        const uid = user.uid;
        const devicesRef = ref(db, `users/${uid}/devices`);
        const newDeviceRef = push(devicesRef);
        await set(newDeviceRef, {
          deviceName: data.deviceName,
          mqttTopic: data.mqttTopic,
        });
      }
    } catch (err) {
      console.error("Erro ao salvar no Realtime DB: ", err);
    } finally {
      navigation.goBack();
    }
  };
  return (
    <TabScroll>
      <BackNavigateButton />
      <Text style={styles.title}>Novo Dispositivo</Text>
      <View style={styles.formContainer}>
        <Controller
          control={control}
          name="deviceName"
          rules={{
            required: "O nome do dispositivo é obrigatório.",
            minLength: {
              value: 3,
              message:
                "O nome do dispositivo deve ter pelo menos 3 caracteres.",
            },
          }}
          render={({ field: { onChange, value } }) => (
            <InputField
              callback={onChange}
              iconName="layers"
              placeholder="Nome do dispositivo"
              secure={false}
              value={value}
            />
          )}
        />

        <Controller
          control={control}
          name="mqttTopic"
          rules={{
            required: "O tópico MQTT é obrigatório.",
            validate: (val) =>
              val.includes("/") ||
              "O tópico MQTT deve conter ao menos uma barra",
            minLength: {
              value: 5,
              message: "O tópico MQTT deve ter pelo menos 5 caracteres.",
            },
          }}
          render={({ field: { onChange, value } }) => (
            <InputField
              callback={onChange}
              value={value}
              iconName="hash"
              placeholder="Tópico MQTT do dispositivo"
              secure={false}
            />
          )}
        />
        <PrimaryButton
          textContent={"Criar"}
          action={handleSubmit(handleDeviceCreation)}
        />
      </View>
    </TabScroll>
  );
};

export default AddDeviceTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    textAlign: "center",
    fontWeight: "700",
    color: colors.dark.softWhite,
    marginVertical: 48,
  },
  formContainer: {
    flex: 1,
    alignItems: "center",
  },
});
