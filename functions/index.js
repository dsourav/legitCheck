const functions = require('firebase-functions');

const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification1= functions.firestore
  .document('pendingCheck/{groupId1}/{groupId2}/{messages}')
  .onCreate((snap, context) => {
    console.log('----------------start function pending--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.from
    const customerEmail=doc.customer_email
    const contentMessage = doc.text

    //notify the user

    if(customerEmail==idFrom){
      console.log(`matched email from to`)
      admin
      .firestore()
      .collection('user')
      .where('role', '==', 'staff').get().then(

        querySnapshot => {
          querySnapshot.forEach(Staffuser => {
            console.log(`Found user to: ${Staffuser.data().user_name}`)
            if (Staffuser.data().pushToken) {

              admin
              .firestore()
              .collection('user')
              .where('customer_email', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().customer_name}`)
                  const payload = {
                    notification: {
                      title: `You have a new message from ${userFrom.data().customer_name}`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(Staffuser.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
              // Get info user from (sent)
             
                    
            } else {
              console.log('Can not find pushToken target user')
            }
          })
        }

      )
 

    }
    else{
      console.log(`doesn't match email from to`)
      admin
      .firestore()
      .collection('user')
      .where('customer_email', '==', customerEmail).get().then(

        querySnapshot3 => {
          querySnapshot3.forEach(Useruser => {
     
            if (Useruser.data().pushToken) {
              // Get info user from (sent)
             
              console.log(`Found user from: ${Useruser.data().customer_name}`)
                  const payload2 = {
                    notification: {
                      title: `You have a new message from authentic app`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(Useruser.data().pushToken, payload2)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
            } else {
              console.log('Can not find pushToken target user')
            }
          })
        }

      )

    }

    return null
  })


  exports.sendNotification2 = functions.firestore
  .document('verifiedCheck/{groupId1}/{groupId2}/{messages}')
  .onCreate((snap, context) => {
    console.log('----------------start function verified--------------------')

    const doc = snap.data()
    console.log(doc)

    const idFrom = doc.from
    const customerEmail=doc.customer_email
    const contentMessage = doc.text

    //notify the user

    if(customerEmail==idFrom){
      console.log(`matched email from to`)
      admin
      .firestore()
      .collection('user')
      .where('role', '==', 'staff').get().then(

        querySnapshot => {
          querySnapshot.forEach(Staffuser => {
            console.log(`Found user to: ${Staffuser.data().user_name}`)
            if (Staffuser.data().pushToken) {

              admin
              .firestore()
              .collection('user')
              .where('customer_email', '==', customerEmail)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().customer_name}`)
                  const payload = {
                    notification: {
                      title: `You have a new message from ${userFrom.data().customer_name}`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(Staffuser.data().pushToken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
              // Get info user from (sent)
             
                    
            } else {
              console.log('Can not find pushToken target user')
            }
          })
        }

      )
 

    }
    else{
      console.log(`doesn't match email from to`)
      admin
      .firestore()
      .collection('user')
      .where('customer_email', '==', customerEmail).get().then(

        querySnapshot3 => {
          querySnapshot3.forEach(Useruser => {
     
            if (Useruser.data().pushToken) {
              // Get info user from (sent)
             
              console.log(`Found user from: ${Useruser.data().customer_name}`)
                  const payload2 = {
                    notification: {
                      title: `You have a new message from authentic app`,
                      body: contentMessage,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(Useruser.data().pushToken, payload2)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
            } else {
              console.log('Can not find pushToken target user')
            }
          })
        }

      )

    }

    return null
  })