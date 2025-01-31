import { Text, StyleSheet } from "react-native";
import TabScroll from "../../components/tabScroll";
import InputField from "../../components/inputField";
import { colors } from "../../constants/colors";
import BackNavigateButton from "../../components/backNavigate";
import NavPath from "../../components/navPath";
import { useState } from "react";
import PrimaryButton from "../../components/primaryButton";
import { ref, set } from "firebase/database";
import { auth, db } from "../../firebase/firebaseConfig";

const ServerTab = () => {
  const [editMode, setEditMode] = useState<boolean>(false);
  const [editedText, setEditedText] = useState<string>("");
  const [currentServer, setCurrentServer] = useState<string>("");

  const handleSubmit = async () => {
    try {
      const authInstance = auth;
      const user = authInstance.currentUser;
      if (user) {
        const uid = user.uid;
        const serverRef = ref(db, `users/${uid}/settings/server`);
        console.log("Saving server:", editedText);
        await set(serverRef, {
          server: editedText,
        });
      }
    } catch (err) {
      console.error("Erro ao salvar no Realtime DB: ", err);
    }
  };

  return (
    <TabScroll>
      <BackNavigateButton />
      <Text style={styles.title}>Servidor</Text>
      <NavPath text="Configurações/Servidor" />
      <InputField
        secure={false}
        iconName="server"
        placeholder="Escolha o servidor MQTT a ser utilizado"
        callback={setEditedText}
      />
      <PrimaryButton
        action={handleSubmit}
        textContent={"Salvar"}
      />
    </TabScroll>
  );
};

export default ServerTab;

const styles = StyleSheet.create({
  title: {
    fontSize: 48,
    marginVertical: 32,
    textAlign: "center",
    fontWeight: 700,
    color: colors.dark.softWhite,
  },
});
