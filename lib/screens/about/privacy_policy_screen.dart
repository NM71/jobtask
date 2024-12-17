import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color(0xff3c76ad),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset(
                  "assets/images/rfk_preview.png",
                  color: Color(0xff3c76ad),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(height: 10,),
                // Introduction
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'The ',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),
                      const TextSpan(
                        text:
                            'following terms and any other rules posted on our Site (collectively the “T&C”) constitute an agreement between\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),
                      const TextSpan(
                        text: 'REFRESH KICKS ',
                        style: TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '(also referred as ',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),
                      const TextSpan(
                        text: '(‘REFRESH KICKS ’, ‘RFK’)',
                        style: TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            ' and you, the visitor, governing your access and use of all content and functionalities available at REFRESH KICKS website and related micro-sites and domain names.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),

                      // Registration
                      TextSpan(
                        text: 'Registration\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            '\nWhen you register you are required to provide information about yourself that is true, accurate, current, and complete in all respects. We may change registration requirements from time to time.\nThe account password you provide should be unique and kept secure, and you must notify REFRESH KICKS immediately of any breach of security or unauthorized use of your account. Although Refresh Kicks will not be liable for your losses caused by any unauthorized use of your account, you may be liable for REFRESH KICKS losses or others due to such unauthorized use.\nYour submission of personal information through the store is governed by our Privacy Policy.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),

                      // Orders: Eligibility, payment, acceptance & delivery
                      TextSpan(
                        text:
                            'Orders: Eligibility, payment, acceptance & delivery\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '\nAll orders are subject to acceptance and availability, Items in your shopping basket are not reserved and may be purchased by other customers. REFRESH KICKS will store a record of your transactions for a minimum of one year.\nWe reserve the right, but are not obligated, to limit the sales of our products to any person, geographic region or jurisdiction. This right may be exercised on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at any time without notice, at our sole discretion. We reserve the right to discontinue any product at any time.\nWe do not warrant the quality of any products, services, information or other material purchased or obtained by you, will meet your expectation, or that any errors in the Service will be corrected.\n\n',
                        style: const TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),

                      // Eligibility to Purchase
                      TextSpan(
                        text: 'Eligibility to Purchase\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '\nThe purchase of services/merchandise through REFRESH KICKS website is strictly limited to parties who can lawfully enter into and form contracts on the Internet in accordance with the laws of the State of New York.\nIn order to make purchases on the Site you will be required to provide your personal details. In particular, you must provide your real name, phone number, e-mail address and other requested information as indicated. Furthermore, you will be required to provide payment details that you represent and warrant are both valid and correct and you confirm that you are the person referred to in the Billing information provided.\nThe Site is available only to individuals and others who meet the site’s terms of eligibility, who have been issued a valid credit/debit card or other payment method by a bank acceptable to REFRESH KICKS, and who have authorized REFRESH KICKS to process a charge or charges on their credit/debit card in the amount of the total purchase price for the merchandise which they purchase. Products purchased by the buyer are for personal or gift use and should not be re-sold, used for commercial purposes or any other commercial benefit. In addition, REFRESH KICKS reserves the right to restrict multiple quantities of an item being shipped to any one customer or postal address.\nBy making an offer to purchase merchandise, you expressly authorized us to perform credit checks and, where REFRESH KICKS feels necessary, to transmit or to obtain your credit card information or credit report information (including any updated information) to or from third parties solely to authenticate your identity, to validate your credit/debit card, to obtain an initial credit card authorization and/or to authorize individual purchase transactions.\n\n',
                        style: const TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),
                      const TextSpan(
                        text:
                            'Furthermore, you agree that we may use Personal Information provided by you in order to conduct appropriate anti-fraud checks. Personal Information that you provide may be disclosed to a credit reference or fraud prevention agency, which may keep a record of that information.\n\n',
                        style: TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            'Please refer to our Privacy Policy for further information about how we use your data.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),

                      // Payments
                      TextSpan(
                        text: '\nPayments\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                            '\nPayments are made through WordPress, All credit/debit cardholders are subject to validation checks and authorization by the card issuer. If the issuer of your credit/debit card refuses to authorize payment to REFRESH KICKS, we will not be liable for any delay or non-delivery.\n\nWe take reasonable care, in so far as it is in our power to do so, to keep the details of your order and payment secure, but in the absence of negligence on our part we cannot be held liable for any loss you may suffer if a third party procures unauthorized access to any data you provide when accessing or ordering from the Site.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),

                      // Promotion Codes
                      TextSpan(
                        text: '(I) Promotion Codes\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nPromotion codes are non-transferable and there is no cash alternative. Furthermore, they cannot be used in conjunction with any other promotion code or offers, and must be redeemed by the date published, if provided.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // Pricing Policy
                      TextSpan(
                        text: '(II) Pricing Policy\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nPrices shown on the Site are in US Dollars and are exclusive of taxes. If you are shipping within the USA, a sales tax charge may be added depending on the state’s laws of the shipping address.\n\nAll prices and offers remain valid as advertised from time to time.\n\nThe US Dollar price of a product displayed on the Site at the time the order is accepted will be honored, except in cases of patent error.\n\nIf you are a customer whose credit/debit card is not denominated in US Dollars, the final price will be calculated in accordance with the applicable exchange rate on the day your card issuer processes the transaction.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // Acceptance of Order
                      TextSpan(
                        text: '\nAcceptance of your Order\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nOnce you have made your choice and your order has been placed, you will receive an email acknowledging the details of your order. This email is NOT an acceptance of your order, just a confirmation that we have received it. Unless you cancel your order, acceptance of your order will be perfected upon completion of the packing of your order. Completion of the contract between you and REFRESH KICKS will be perfected when we dispatch the goods to you. The sale contract is therefore concluded in the State of New York, USA, and the language of the contract is English.\n\nWe reserve the right not to accept your order in the event, for example, that we are unable to obtain authorization for payment, that shipping restrictions apply to a particular item, that the item ordered is out of stock or does not satisfy our quality control standards and is withdrawn, or that you do not meet the eligibility criteria set-out within this T&C. Furthermore, we may refuse to process a transaction for any reason or refuse service to anyone at any time at our sole discretion. We will not be liable to you or any third party by reason of our withdrawing any merchandise from the Site.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),



                      // Delivery
                      TextSpan(
                        text: 'Delivery\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nREFRESH KICKS, and/or its courier, may leave your package(s) outside the premises at the shipping address provided by you without obtaining a signature for proof of delivery. You authorize REFRESH KICKS to leave the package(s) at the shipping address without obtaining a signature and release and indemnify REFRESH KICKS from liability for any loss or damage that may result from leaving the package(s) at your shipping address without obtaining a signature. We only ship to the confirmed address provided by Stripe or your credit card vendor. Shipping typically takes 2-5 business days on US-based orders, and 7-14 days on international orders, subject to the customer’s location.\n\nEstimated delivery times are to be used as a guide only. We are not responsible for any delays caused by destination customs clearance processes.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),



                      // RETURNS, REFUNDS AND EXCHANGES
                      TextSpan(
                        text: 'Returns, Refunds and Exchanges\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nIf you wish to return an item you bought online, please contact us at info@rfkicks.com within 7 days of receiving your order. All returns are subject to the following rules:\n\n● All sales are final and may not be returned, exchanged, or refunded.\n● You will be credited in full minus all shipping charges.\n● We do not pay for returns to be shipped back to us.\n● We reserve the right to deny unreasonable repairs, returns and exchanges.\n\nPlease note we have made every effort to display as accurately as possible the colors of the products that appear on the Site. We cannot guarantee that your computer monitor’s display of any color will be accurate.\n\nFor more information please refer to our ‘Shipping and Refund Policy\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),



                      // CONTENT
                      TextSpan(
                        text: 'Content\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\n“Content” is defined as all information such as the “look and feel” of the Site, data files, graphics, text, photographs, drawings, logos, images, sounds, music, video or audio files on this Site. REFRESH KICKS tries to ensure that the information on this site is accurate and complete. REFRESH KICKS does not warrant or represent that all Content is accurate, error-free or reliable or that your use of REFRESH KICKSContent will not infringe rights of third parties. Your use of the Web Site is at your risk. REFRESH KICKS does not warrant that the functional aspects of the Web Site or REFRESH KICKS Content will be error free or that this Web Site, REFRESH KICKS Content or the server that makes it available are free of viruses or other harmful components. If your use of this Site, or REFRESH KICKS Content results in the need for servicing or replacing property, material, equipment or data, REFRESH KICKS is not responsible for those costs.\n\nWithout limiting the foregoing, everything on the Web Site is provided to you “as is” and “as available” without warranty of any kind, either expressed or implied, including, but not limited to, the implied warranties of merchantability, satisfactory quality, fitness for a particular purpose, reasonable care and skill, or non-infringement.\n\nREFRESH KICKS reserves the right to withdraw, temporarily or permanently, any Content from this Site at any time and for any reason. Removal may be immediate and without notice. You confirm that REFRESH KICKS is not liable to you or any third party for any such withdrawal.\n\nBy posting you agree to be solely responsible for the content of all information you contribute. You also grant to REFRESH KICKS a right to use any content you provide for its own purposes including republication in any form or media.\n\nREFRESH KICKS does not commit to checking all content and will not be liable for third party posts. REFRESH KICKS reserves the right at its sole discretion not to publish or to remove any comment including those that it believes may be unlawful, defamatory, racist or libelous, incite hatred or violence, detrimental to people, institutions, religions or to people’s privacy, which may cause harm to minors, is detrimental to the trade marks, patents and copyrighted content, contains personal data, improperly uses the medium for promoting and advertising businesses. This site is available to the public, information you consider confidential should not be posted to this site.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // INTELLECTUAL PROPERTY RIGHTS
                      TextSpan(
                        text: 'Intellectual Property Rights\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nYou acknowledge and agree that all copyright, designs, the “look and feel” of the Site, trademarks and all other intellectual property and material rights relating to the Content as herein described shall remain at all times vested in REFRESH KICKS.\n\nAll such Content, including third party trademarks, designs and related intellectual property rights mentioned or displayed on this Site are protected by federal and state laws and regulations and international treaty provisions. Any reproduction or redistribution of the above listed Content is prohibited and may result in civil and criminal penalties. Violators will be prosecuted to the fullest extent permissible under applicable law. Without limiting the foregoing, copying and use of the above listed materials to any other server, location or support for publication, reproduction or distribution is expressly prohibited.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // USE
                      TextSpan(
                        text: 'Use\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nThis Site is for your personal non-commercial use only. You may not modify, copy, distribute, transmit, display, perform, reproduce, publish, license, commercially exploit, create derivative works from, transfer, or sell any Content, software, products, or services contained within this Site. You may not use this Site, or any of its Content, to further any commercial purpose, including any advertising or advertising revenue generation activity on your own Site.\n\nYou use this Site at your sole risk. You agree that you will be personally responsible for your use of this Site and for all of your communication and activity on this Site. We reserve the right to deny you access to this Site, or any part of this Site, at any time without notice. If we determine, in our sole discretion, that you engaged in prohibited activities, were not respectful of other users, or otherwise violated the T&C, we may deny you access to this Site on a temporary or permanent basis and any decision to do so is final. You agree that you shall not remove, obscure, or alter any proprietary rights notices (including copyright and trade mark notices) which may be affixed to or contained within the Site. You agree not to collect or harvest any personally identifiable information, including account names, from the Site, nor to use the communication systems provided by the Site for any commercial solicitation purposes. You agree not to solicit, for commercial purposes, any users of the Site with respect to any submissions made by them.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // THIRD PARTY
                      TextSpan(
                        text: 'Third Party\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nWe may include hyperlinks on this Site to other websites or resources operated by parties other than REFRESH KICKS including advertisers. REFRESH KICKS has not reviewed all of the sites linked to its Web Site and is not responsible for the content or accuracy of any off-site pages nor are we responsible for the availability of such external websites or resources, and do not endorse and are not responsible or liable, directly or indirectly, for the privacy practices or the content of such websites, including (without limitation) any advertising, products or other materials or services on or available from such websites or resources, nor for any damage, loss or offence caused or alleged to be caused by, or in connection with, the use of or reliance on any such content, goods or services available on such external websites or resources.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // ACCURACY, COMPLETENESS AND OMISSIONS
                      TextSpan(
                        text: 'Accuracy, Completeness and Omissions\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nWhile we will use reasonable endeavors to verify the accuracy of any information it places on the Site, it makes no warranties, whether express or implied in relation to its accuracy. This Site is provided on an “as is” and “as available” basis without any representation or endorsement made and we make no warranties of any kind, whether express or implied, in relation to this Site, or any transaction that may be conducted on or through this Site including but not limited to, implied warranties of non-infringement, compatibility, security, accuracy, conditions of completeness, or any implied warranty arising from course of dealing or usage or trade.\n\nThere may be information on our site that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability. We reserve the right to correct any errors, inaccuracies or omissions, and to change or update any information or cancel orders if any information is inaccurate at any time without prior notice (including after you have submitted your order). We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law.\n\nWe make no warranty that this Site will meet your requirements or will be uninterrupted, timely, secure or error-free, that defects will be corrected, or that this Site or the server that makes it available are free of viruses or bugs or represents the full functionality, accuracy, reliability of the materials. We will not be responsible or liable to you for any loss of Content or material uploaded or transmitted through this Site.  To the fullest extent permissible under applicable law, we disclaim any and all warranties of any kind, whether express or implied, in relation to the products available through this Site including but not limited to, implied warranties of satisfactory quality and fitness for a particular purpose. Nothing in these T&C shall limit your rights as a consumer under the laws of the State of New York.\n\nYou acknowledge that we cannot guarantee and therefore shall not be in any way responsible for the security or privacy of this Site and any information provided to or taken from this Site by you.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      // INDEMNIFICATION
                      TextSpan(
                        text: 'Indemnification\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nAt our request, you agree to fully defend, indemnify and hold harmless REFRESH KICKS immediately on demand, its officers, directors, agents, affiliates, licensors, and suppliers, from and against all liabilities, claims, expenses, damages and losses, including legal fees, arising from any breach of the T&C by you or any other liabilities arising out of your use of this Site, or the use by any other persons accessing this Site using your Internet account. We reserve the right, at our own expense, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you hereunder. This defense and indemnification obligation will survive these T&C and your use of the Site and the Services.\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),



                      // General Legal Terms
                      TextSpan(
                        text: 'General Legal Terms\n',
                        style: const TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text:
                        '\nComplete Terms: The T&C constitute the whole legal agreement between you and REFRESH KICKS and govern your use of the Services and completely replace any prior agreements between you and REFRESH KICKS in relation to the Services. Notwithstanding the foregoing, you understand that REFRESH KICKS may make changes to the T&C from time to time. You agree that REFRESH KICKS is under no obligation to provide you with notices regarding changes to the T&C. You understand that it is your responsibility to check the T&C regularly for changes.\n\nModifications to the Services: You acknowledge and agree that the form and nature of the Services which REFRESH KICKS provides may change from time to time without prior notice to you. You further acknowledge and agree that REFRESH KICKS may stop (permanently or temporarily) providing the Services (or any features within the Services) to you or to users generally at REFRESH KICKS sole discretion, without prior notice to you.\n\nConfidentiality: You understand that REFRESH KICKS grants the operators of public search engines permission to use spiders to copy materials from the site for the sole purpose of creating publicly available searchable indices of the materials, but not caches or archives of such materials. REFRESH KICKS reserves the right to revoke these exceptions either generally or in specific cases.\n\nLiability in the Event of Breach: You agree that you will comply with all of the provisions of the T&C. You understand REFRESH KICKS may suffer) of any such breach.\n\nRights Not Waived: You agree that if REFRESH KICKS does not exercise or enforce any legal right or remedy which is contained in the T&C (or available under any applicable law), this will not be taken to be a formal waiver of REFRESH KICKS rights and that those rights or remedies will still be available.\n\nSeverability: If any court of law, having the jurisdiction to decide on this matter, rules that any provision of this T&C is invalid, then that provision will be removed from the T&C without affecting the rest of the T&C. The remaining provisions of the T&C will continue to be valid and enforceable.\n\nGoverning Law: The T&C, and your relationship with REFRESH KICKS under the T&C, shall be governed by the laws of the State of New York. You and REFRESH KICKS agree to submit to the exclusive jurisdiction of the State and Federal courts in New York City, New York, and waive any claim or defense of inconvenient forum or lack of personal jurisdiction in such forum under any applicable law or decision or otherwise.\n\nViolation of T&C: Please report any violations of the T&C by emailing info@rfkicks.com\n\nIndependent Relationship: You and REFRESH KICKS are independent contractors, and these T&C, including but not limited to submission or distribution of any Content you created, will not, in whole or in part, establish any relationship of partnership, joint venture, employment, franchise or agency between the you and REFRESH KICKS. Neither party will have the power to bind the other or incur obligations on the other’s behalf without the other’s prior written consent. Neither party is authorized to act as an agent or representative of the other or for or on behalf of the other party in any capacity other than as expressly set forth in the T&C. Neither party shall in any manner advertise, represent or hold itself (or any of its agents) out as so acting or being authorized so to act, or incur any liabilities or obligations on behalf of, or in the name of, the other party, unless specifically provided for in the T&C.\n\n\n',
                        style: TextStyle(
                          color: Color(0xff767676),
                          fontFamily: 'OC-Regular',
                        ),
                      ),


                      const TextSpan(
                        text: 'Questions about the T&C should be sent to us at ',
                        style: TextStyle(
                            color: Color(0xff3c76ad),
                            fontFamily: 'OC-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' info@rfkicks.com',
                        style: TextStyle(
                            color: Color(0xffcc3366),
                            fontFamily: 'OC-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
