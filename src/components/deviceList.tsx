import { StyleSheet, View } from "react-native";
import DeviceCard from "./deviceCard";
import { useEffect, useState } from "react";
import { ref, onValue, update } from "firebase/database";
import { auth, db } from "../firebase/firebaseConfig";
import Loader from "./loader";

interface Device {
  id: string;
  deviceName: string;
  mqttTopic: string;
  state: boolean;
}
const DeviceList = () => {
  const [devices, setDevices] = useState<Device[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    const fetchDevices = async () => {
      try {
        const authInstance = auth;
        const user = authInstance.currentUser;

        if (user) {
          const uid = user.uid;
          const devicesRef = ref(db, `users/${uid}/devices`);

          onValue(devicesRef, (snapshot) => {
            if (snapshot.exists()) {
              const data = snapshot.val();
              const deviceList = Object.keys(data).map((key) => ({
                id: key,
                ...data[key],
              }));
              setDevices(deviceList);
            } else {
              setDevices([]);
            }
            setLoading(false);
          });
        }
      } catch (err) {
        console.error("Erro ao recuperar dispositivos:", err);
        setLoading(false);
      }
    };

    fetchDevices();
  }, []);

  const toggleDeviceState = (deviceId: string, newState: boolean) => {
    const deviceRef = ref(
      db,
      `users/${auth.currentUser?.uid}/devices/${deviceId}`
    );
    update(deviceRef, { state: newState });
  };

  if (loading) {
    return <Loader />;
  }

  return (
    <View style={styles.deviceList}>
      {devices.map((device) => (
        <DeviceCard
          onClick={() => toggleDeviceState(device.id, !device.state)}
          key={device.id}
          deviceName={device.deviceName}
          mqttTopic={device.mqttTopic}
          deviceState={device.state}
        />
      ))}
    </View>
  );
};

export default DeviceList;

const styles = StyleSheet.create({
  deviceList: {
    width: "100%",
    marginVertical: 8,
    alignItems: "center",
  },
});
